package hello_world_pkg;
`include "uvm_macros.svh" //macros used my uvm (Ex.:component_utils,object_utils for factory registration)
import uvm_pkg::*; //uvm base class library

class hello_world_test extends uvm_test;
  `uvm_component_utils(hello_world_test)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology(); //uvm_top is a handle to uvm_root class & uvm_test_top is the instance name of the test(in this case hello_world_test) class we run
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this, "raised objection");
    `uvm_info(this.get_full_name(),$sformatf("Hello World\n"),UVM_LOW)
    phase.drop_objection(this, "drop objection");
  endtask
  
endclass
endpackage
  
  
module top;
  import uvm_pkg::*;
  import hello_world_pkg::*;
  
  initial run_test("hello_world_test"); //global uvm task which either fetches argument from CLA UVM_TESTNAME or reads the arg passed when invoked to construct a test object with factory
endmodule