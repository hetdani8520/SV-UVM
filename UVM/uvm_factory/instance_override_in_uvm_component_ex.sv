//factory override by instance for component objects (PARTICULAR INSTANCE OVERRIDE ONLY)
//The below example performs instance override with factory for only ONE instance of cfg1 class with cfg2 class.
//base class
class cfg1 extends uvm_component;
  `uvm_component_utils(cfg1)
  
  rand bit [3:0] a;
  
  constraint a_random {a inside {[0:15]};}
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

//derived class cfg2 extended from cfg1
class cfg2 extends cfg1;
  `uvm_component_utils(cfg2)
  
  constraint a_sticky_4 {a == 4;} //override constraint on a in derived class
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

//test_base class where factory overrides take place
class test_base extends uvm_test;
  `uvm_component_utils(test_base)
  
  //intention to create 4 instances of cfg1 class (array of handles)
  cfg1 cfg1_h[4];
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //instance override of particular instance of cfg1 class (cfg1_h[3]) with cfg2 class (hierarchical path to specific instance to be overriden provided as arg to set_inst_override() method)
    cfg1::type_id::set_inst_override(cfg2::get_type(), "uvm_test_top.cfg1_h[3]");
    //all instance creation for cfg1 class (only cfg1_h[3] instance will be overriden with cfg2 class)
    cfg1_h[0] = cfg1::type_id::create("cfg1_h[0]", this); 
    cfg1_h[1] = cfg1::type_id::create("cfg1_h[1]", this);
    cfg1_h[2] = cfg1::type_id::create("cfg1_h[2]", this);
    cfg1_h[3] = cfg1::type_id::create("cfg1_h[3]", this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
     uvm_factory::get.print();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this, "raise objection");
    //since only cfg1_h[3] instance is overriden with cfg2 class so random value of a generated for that instance will be based on constraints defined on a in cfg2 class. for rest instances, the random value of a generated will be based on constraints defined on a in cfg1 class. 
    for(int j=0;j<4;j++) begin
      assert(cfg1_h[j].randomize()) else
      `uvm_fatal("RANDERR","Randomization failed");
      `uvm_info("TEST_BASE",$sformatf("value of a =%d",cfg1_h[j].a),UVM_LOW);
    end
    phase.drop_objection(this, "drop objection");
  endtask
endclass

module tb;
  initial begin
    run_test("test_base");
  end
endmodule