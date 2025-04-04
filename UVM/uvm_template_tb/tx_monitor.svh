
class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor)
  
  //usually create as much analysis ports as much diff seq_items you have
  uvm_analysis_port #(tx_item) tx_item_port;
  
  //virtual interface handle
  virtual intf vif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    //can also create with new() as base class is never inherited so registering it with factory not useful
    tx_item_port = uvm_analysis_port::type_id::create("tx_item_port");
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //get the vif handle from cfg_db to invoke intf methods to sample pin wiggles into tx_item txns
    if(!uvm_config_db #(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(), "Failed to get vif from uvm_config_db")
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //use this when you have diff seq_items for input & output intf signals
    /*
    fork
      get_an_input();
      get_an_output();
    join
    */
    
    fork
      get_tx_item();
    join
    endtask:run_phase
    
    task get_tx_item();
      //monitor dut inputs
      forever begin
      tx_item txn_mon;
      txn_mon=tx_item::type_id::create("txn_mon");
      //get dut inputs from interface
        vif.get(txn_mon);
      `uvm_info("TX_IN", txn.convert2string, UVM_FULL)
      tx_item_port.write(txn_mon);
      end
    endtask
    
    //vif method to get intf signals into txn
    //this can ideally be done under interface
    task automatic get(tx_item txn);
    //capture the DUT inputs synchronously
    @(posedge vif.clk);
    txn.addr = vif.addr;
    txn.data = vif.data;
  endtask
    
endclass