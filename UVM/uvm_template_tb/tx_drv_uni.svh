//Parameterization of REQ & RSP must match across sequence, driver & sequencer
//Trying to establish unidirectional comm
class tx_driver_uni extends uvm_driver #(tx_item);
  `uvm_component_utils(tx_driver_uni)
  
  virtual vif;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get vif pointer/handle from cfg_db
    //all dummy syntax used
    if(!(uvm_config_db)#(virtual ifc)::get(this,"drv","virtual_if",vif))
      `uvm_fatal(get_type_name(), "Failed to get vif from uvm_config_db")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      tx_item txn_drh;
      seq_item_port.get_next_item(txn_drh);
      vif.send(txn_drh); //this could be either defined in drv or interface
      seq_item_port.item_done(txn_drh)
    end
    
      //turn a txn into pin wiggles (called by driver)
    task automatic send(tx_item txn);
    @(posedge clk);
    vif.addr <= txn.addr;
	vif.data <= txn.data;
  	endtask
    
    
    
  endtask
endclass