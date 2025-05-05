//tx_seq
class tx_seq extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_seq)
  
  tx_item req;
  tx_item rsp;
  
  function new(string name);
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(10) begin
    req=tx_item::type_id::create("req", this);
    start_item(req);
    assert(req.randomize()) else
        `uvm_fatal("RAND_ERR","randomization error");
    finish_item(req);
    //this will block until the rsp is put from driver side into sqr rsp fifo
      get_response(rsp);
    end
  endtask
endclass

//tx_driver
class tx_driver extends uvm_driver #(tx_item);
  `uvm_component_utils(tx_driver)
  
  tx_config tx_cfg;
  virtual tx_ifc vif;
  
  tx_item req;
  tx_item rsp;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    if(!uvm_cpnfig_db#(tx_config)::get(this,"","tx_cfg",tx_cfg))
      `uvm_fatal("CFGDBERR","cfg_db type not found")
    
    //vif assign
    vif = tx_cfg.vif;
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this,"start obj");
    forever begin
      rsp=tx_item::type_id::create("tx_item");
      seq_item_port.get(req);
      vif.send(req);
      //set the txn of rsp item same as its corr req_item
      //The sequence_item set_id_info method is used to set a response item id from a the id field in request item. 
      rsp.set_id_info(req);
      seq_item_port.put(rsp);
    end
    phase.drop_objection(this,"drop obj");
  endtask
endclass