//Acquiring a sequenceR handle to start a sequencE
//How does a test find a sequencer handle to pass to a sequence's start()?

//Ans:- Store a sqr handle in the agt configuration object
//->set the handle in the agt's build_phase after creating a sqr
//->any component or sequence that can access the cfg object can find the handle

//--------------------------------------------------------------------------------------

//ahb_agt config object
class ahb_config extends uvm_object; //agent configuration
  //factory regs & constructor
  
  uvm_sequencer #(ahb_txn) sqr; //null sqr handle
  
  //other config properties like active_passive_enum....
endclass

//ahb_test_base class
class ahb_test_base extends uvm_test;
  //instantiate ahb_agt config class
  ahb_config ahb_cfg; //agt config object
  ...
  
  virtual function void build_phase(uvm_phase phase);
    //create ahb agt config class
    ahb_cfg=ahb_config::type_id::create("ahb_cfg");
    
    //set the cfg object in cfg_db (could be done in env too)
    uvm_config_db#(ahb_config)::set(this,"env*","ahb_cfg",ahb_cfg);
    
    //create env config objects & instantiate env...
    ....
  endfunction
endclass

//ahb_agent
class ahb_agent extends uvm_agent;
  //factory regs & constructor
  
  ahb_config ahb_cfg; //config object handle
  virtual ahb_interface vif;
  uvm_sequencer #(ahb_txn) sqr; //sequencer handle
  ...
  
  virtual function void build_phase(uvm_phase phase);
    //get the agt cfg from cfg_db
    if(!uvm_config_db#(ahb_config)::get(this,"","ahb_cfg",ahb_cfg))
      `uvm_fatal("NOCFG","ahb_cfg not found in cfg_db");
    
    if(ahb_cfg.active == UVM_IS_ACTIVE) begin
    sqr = uvm_sequencer::type_id::create("sqr");
    end
    //copy sqr handle to agt config object
    ahb_cfg.sqr = sqr;
    
  endfunction
endclass

//ahb_test class extending from ahb_test_base
class ahb_test extends ahb_test_base;
  //factory regs & constructor
  
  function void build_phase(uvm_phase phase);
    super.build_phase();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    ahb_seq seq;
    super.run_phase(phase);
    seq=ahb_seq::type_id::create("seq");
    phase.raise_objection(this,"start obj");
    //start a seq using sqr from ahb agt config object
    seq.start(ahb_cfg.sqr);
    phase.drop_objection(this, "end obj");
  endtask
endclass