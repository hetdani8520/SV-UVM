/*
Notes:
1)Testbench-level data gathered by a coverage collector in the environment
-->can see multiple agents & do cross coverage between agents - default location
2)For protocol coverage, put the coverage collector in an agent
-->agent is self-contained, reusable building block
3)Coverage collectors have one or more analysis imp exports connected to monitor's analysis port
*/

/*
Debugging Coverage:
Why is my coverage 0%?
Common Problems:
a)testbench or DUT has a bug (and as a result txns were not produced)
b)cov collector was not created? (If creation was dependent on some config knob in agent/env)?
c)covergroup was not constructed in the class constructor (under new() method?)
d)cov collectors analysis imp export was not connected to monitor's analysis port
e)the t handle (which is input arg of write() func) was not copied into covergroup's txn handle
f)sample() method was not called in the write() method?
*/

class tx_item extends uvm_sequence_item;
  `uvm_object_utils(tx_item)
  
  rand bit [7:0] drbg_gen_size;
  
  rand bit [7:0] drbg_inst_size;
  
  typedef enum logic [1:0] {ENT_PCS, NRBG_SETUP, DRBG_SETUP, SELF_TEST} modes;
  
  rand mode modes;
  
  rand bit test_mode;
  
  function new(string name="tx_item");
    super.new(name);
  endfunction
  
  
endclass

class tx_coverage_collector extends uvm_subscriber #(tx_item);
  `uvm_component_utils(tx_coverage_collector)
  
  tx_item txn;
  
  //The way the functional coverage is written currently, the type_coverage == instance_coverage & the instance coverage solely comes from cross products (which is intentional as this prevents duplicate coverage sampling from coverpoints)
  covergroup cvg;
    option.per_instance=1;
    
    //this coverpoint could be written in 2 ways:
    //1)without explicit bins (in this case tool will generate an implicit bin for all legal values of enum "modes")
    //2)with explicit bins (explicitly defining bins under a coverpoint restricts the scope of that coverpoint to only those bins, which is very useful from a cross coverage POV) [ this is employed below as well]
    op_modes: coverpoint txn.modes {
      bins ent_pcs = {0};
      bins nrbg_setup = {1};
      bins drbg_setup = {2};
      bins self_test  = {3};
      //This would mean that coverage of this coverpoint will only get accumulated into type/instance coverage if it is used in a cross coverage.
      option.weight = 0; //disabling the coverpoint's coverage from getting accumulated into instance coverage of the covergroup
      type_option.weight = 0; //disabling the coverpoint's coverage from getting accumulated into type coverage of the covergroup
    }
    
    test_mode_status: coverpoint txn.test_mode{
      bins test_mode_en = {1}; //GET_NOISE
      bins test_mode_dis = {0}; //ENT_PCS
    }
    
    //legal random number sizes are only a multiple of 32bytes
    rnd_size: coverpoint txn.drbg_gen_size {
      bins legal_rnd_size[] = {[32:128]} with (item % 32 == 0);
      option.weight = 0;
      type_option.weight = 0;
    }
    
    //legal seed sizes are from 32:159 bytes (at every byte granularity)
    seed_size: coverpoint txn.drbg_inst_size {
      bins legal_seed_size[] = {[32:159]};
      option.weight = 0;
      type_option.weight = 0;
    }
    
    //transition bins to cover/track functional flow of module in functional coverage
    nrbg_flow_transition: coverpoint txn.modes{
      bins nrbg_setup_transition = {3=>0=>1[*256]}; //nrbg_setup_flow (256 times also ensures reseed counter overflow)
      bins drbg_setup_transition = {3=>2};          //drbg_setup_flow
    }
    
    //This only covers 2 combinations: 1)ent_pcs x test_mode_en, ent_pcs x test_mode_dis
    //cross to cover ent_pcs modes with enabled & disabled test_mode configuration
    cross_ent_pcs_x_test_mode: cross txn.modes,txn.test_mode{
      ignore_bins redundant_1 = binsof(txn.modes) intersect {1,2,3} && binsof(test_mode); 
    }
    
    //cross of all possible rnd_sizes with nrbg_setup & drbg_setup modes
    cross_mode_x_drbg_gen_size: cross txn.modes, txn.drbg_gen_size{
      ignore_bins remove_mode_0_3_crosses = binsof(txn.modes) intersect {0,3} && binsof(txn.drbg_gen_size);
    }
    
    //cross of all legal seed values with only drbg_setup modes (as this modes only uses user-defined seeds)
    cross_mode_x_drbg_inst_size: cross txn.modes, txn.drbg_inst_size{
      ignore_bins remove_red_modes = binsof(txn.modes) intersect {0,1,3} && binsof(txn.drbg_inst_size);
    }
  endgroup
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    cvg=new();
  endfunction
  
  //empty body prototype for this function (pure virtual) defined in its base class (uvm_subscriber)
  //This method will be invoked whenever monitor broadcasts txns over its analysis port
  virtual function void write(input tx_item t);
    //copy txn handle "t" to class property "this.txn"
    this.txn = t;
    
    //if(<trigger condition (if any)>) begin
    cvg.sample();
    //end
  endfunction
  
  //This is just for debug purposes
  virtual function void report_phase(uvm_phase phase);
    `uvm_info("DEBUG", $sformatf(""coverage for collector %s = %6.2f%%\n",get_full_name(),cvg.get_coverage()),UVM_MEDIUM)
  endfunction
  
endclass
