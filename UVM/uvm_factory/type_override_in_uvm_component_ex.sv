//factory override by type for component objects
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
    //type override of cfg1 class with cfg2 class (both are polymorphic compatible)
    cfg1::type_id::set_type_override(cfg2::get_type(), 1);
    //all instances of cfg1 class will be overriden to type cfg2
    //because type override applies to all instances
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
    //This will print random value of a for all the 4 instances of cfg1 class which are type overriden by cfg2 class (hence, a will abide by any constraints in overriden class cfg2)
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