//uvm_singleton_object
//The below code creates a singleton class first in the "test" which instance is shared by the environment as well.
class singleton;
  
  local static singleton singleton_h;
  string name;
  
  local function new();
  endfunction
  
  static function singleton getObj();
    if(singleton_h == null)
      singleton_h = new();
    return singleton_h;
  endfunction
    
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    singleton sh = singleton::getObj();
    super.build_phase(phase);
    `uvm_info("ENV",$sformatf("%s",sh.name),UVM_LOW)
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env env_h;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    singleton sh = singleton::getObj();
    super.build_phase(phase);
    sh.name = "This is test";
    `uvm_info("TEST",$sformatf("%s",sh.name),UVM_LOW)
    env_h = env::type_id::create("env_h",this);
  endfunction

endclass

module top;
  import uvm_pkg::*;
  
  initial begin
    run_test("test");
  end
endmodule