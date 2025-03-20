//Seqr-driver communication
//sequence performs delayed randomization so that all randomized values are recieved by driver
class tx_item extends uvm_sequence_item;
  `uvm_object_utils(tx_item)
  
  rand bit [3:0] a;
  
  function new(string name="tx_item");
    super.new(name);
  endfunction
endclass

class tx_seq extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_seq)
  
  function new(string name="tx_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    tx_item txn;
    
    repeat(5) begin
      txn=tx_item::type_id::create("txn");
      start_item(txn);
      assert(txn.randomize()) else
        `uvm_info("SEQ",$sformatf("txn::randomizaton failed"),UVM_LOW)
      finish_item(txn);
    end
  endtask
  
endclass

class tx_drv extends uvm_driver #(tx_item);
  `uvm_component_utils(tx_drv)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    //this will ideally create a virtual inf handle which will be assigned a handle to actual interface via cfg_db static get() func call
    //vif handle is required by driver to call bfm/intf methods inside driver which will actually drive the txns from driver via interface to the DUT
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    tx_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      //call interface methods to drive txn to dut
      //vif.transfer(txn)
      //all 5 txns from sequence are recieved by driver & later driven via intf to DUT
            `uvm_info("DRV",$sformatf("txn recvd:driving txn to DUT:value=%d",txn.a),UVM_LOW)
      seq_item_port.item_done(txn);
    end
  endtask
endclass

class tx_test extends uvm_test;
  `uvm_component_utils(tx_test)
  
  tx_drv drv;
  uvm_sequencer #(tx_item) sqr;
  tx_seq seq;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build_phase is executed top-down
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //create drv object (ideally happens in agent)
    drv=tx_drv::type_id::create("tx_drv",this);
    
    //create seqr object (ideally happens in agent)
    //never extended
    //not needed to register with factory
    sqr=new("sqr",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //initiator.port.connect(target.imp)
    //control is always with driver as it is nearest to the DUT & one can only drive txns at as much rate as the DUT can accept them. component nearest to the DUT is initiator
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    seq = tx_seq::type_id::create("seq",sqr);
    seq.start(sqr);
  endtask
  
endclass

module drv_seq_comm;
  initial begin
    run_test("tx_test");
  end
endmodule