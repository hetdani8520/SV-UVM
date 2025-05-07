//Factory override examples in uvm_objects

//dummy seq items for compile through successfully
class my_req extends uvm_sequence_item;
  `uvm_object_utils(my_req)
  
  function new(string name="my_req");
    super.new(name);
  endfunction
endclass


//seq_base
class seq_base extends uvm_sequence #(my_req);
  `uvm_object_utils(seq_base)
  
  my_req req;
  
  rand bit [3:0] a;
  
  constraint a_random {soft a inside {[0:3]};}
  
  function new(string name="seq_base");
    super.new(name);
  endfunction
endclass

//seq_child extends from seq_base
class seq_child extends seq_base;
  `uvm_object_utils(seq_child)
  
  constraint a_sticky {a == 15;}
  
  function new(string name="seq_child");
    super.new(name);
  endfunction
endclass

//seq_override test class
class test_seq_override extends uvm_test;
  `uvm_component_utils(test_seq_override)
  
  //base class objects will be overriden by seq_child
  seq_base seq_base_h[4];
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    //type override
    seq_base::type_id::set_type_override(seq_child::get_type(),1);
    
    //inst override (specific instance)
    //seq_base::type_id::set_inst_override(seq_child::get_type(),"uvm_test_top.seq_base_h[3]");
    
    super.build_phase(phase);
    seq_base_h[0]=seq_base::type_id::create("seq_base_h[0]", this); //"this" is important while uvm_object class creation to facilitate inst_override of seq classes/uvm_objects
    seq_base_h[1]=seq_base::type_id::create("seq_base_h[1]", this);
    seq_base_h[2]=seq_base::type_id::create("seq_base_h[2]", this);
    seq_base_h[3]=seq_base::type_id::create("seq_base_h[3]", this);
             
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    uvm_factory::get().print();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this,"start obj");
    for(int i=0;i<4;i++) begin
      assert(seq_base_h[i].randomize()) else
        `uvm_fatal("RANDERR","Randomization error")
        `uvm_info("TEST_SEQ_OVERRIDE",$sformatf("a=%d",seq_base_h[i].a),UVM_LOW);
    end
    phase.drop_objection(this,"drop obj");
  endtask
  
  
endclass


//call run_test()
module test;
  
  initial begin
    run_test("test_seq_override");
  end
endmodule