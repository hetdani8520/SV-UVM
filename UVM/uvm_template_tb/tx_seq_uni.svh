//Parameterization of REQ & RSP must match across sequence, driver & sequencer
//Trying to establish unidirectional comm
class tx_seq extends uvm_sequence #(tx_item); //by default RSP=REQ
  `uvm_object_utils(tx_seq)
  
  rand bit [3:0] num;
  
  function new(string name="tx_seq");
    super.new(tx_seq);
  endfunction
  
  virtual task body();
    tx_item txn_h;
    repeat(num) begin
      txn_h=tx_item::type_id::create("txn_h");
      start_item(txn_h);
      //can use inline constraints here to override constraints in seq_item inline (make sure hard constraints are not overriden incorrectly to create solver conflicts)
      assert(txn_h.randomize()) else
        `uvm_fatal(get_type_name(),"Randomization failed")
      finish_item(txn_h);
      //after finish_item is unblocked is when response handshake is completed & hence get_response() is valid afterwards
      //get_response() -->this will get response from driver if the rsp is part of the same req seq_item
    end
  endtask
  
endclass