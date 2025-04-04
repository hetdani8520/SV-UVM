//Sequence_item hierarchy for real-DUT
//-->tx_base (this seq_item contains all the do_* methods)
//	-->tx_in (this seq_item contains all input interface signals to be randomized)
//	-->tx_out (this seq_item contains output responses from DUT)


class tx_item extends uvm_sequence_item;
  `uvm_object_utils(tx_item)
  
  //32-bit address & data bus
  rand bit [31:0] addr;
  rand bit [31:0] data;
  
  //1-bit response
  bit response;
  
  function new(string name="tx_item");
    super.new(name);
  endfunction
  
  //could be used by coverage/scoreboards
  virtual function do_copy(uvm_object rhs);
    tx_item rhs_;
    if(!($cast(rhs_,rhs)))
      `uvm_fatal(get_type_name(), "Illegal rhs argument")
      super.do_copy(rhs_);
    
    this.addr = rhs_.addr;
    this.data = rhs_.data;
    this.response = rhs_.response;
    
  endfunction
  
  //could be used by scoreboards
  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    tx_item rhs_;
    if(!($cast(rhs_,rhs)))
      `uvm_fatal(get_type_name(), "Illegal rhs argument")
    
      return (super.do_compare(rhs,comparer) && (this.addr === rhs_.addr) && (this.data === rhs_.data) && (this.response === rhs_response));
  endfunction
  
  //used primarily for verbose debug
  virtual function string convert2string;
    string s = super.convert2string();
    $sformatf(s,"addr=%h",addr);
    $sformatf(s,"data=%h",data);
    $sformatf(s,"response=%d",response);
    
    return s;
  endfunction
  
  
endclass