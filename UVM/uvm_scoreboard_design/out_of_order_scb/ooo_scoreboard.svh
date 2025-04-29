//OOO scoreboard design
//The below-mentioned ooo scb design is completely COPIED from Shimon Cohen's ooo scb design
//The below-design is only made public for learning purposes.
//Credits for the below design:- https://github.com/verification-explorer/out_of_order_comparator/blob/main/sv/txn_ooo_comp.sv
`uvm_analysis_impl_decl(_expected)
`uvm_analysis_impl_decl(_actual)

class txn_ooo_comparator extends uvm_component;
  `uvm_component_utils(txn_ooo_comparator)
  
  uvm_analysis_imp_expected #(txn, this) analysis_imp_exp;  //analysis imp port for expected_txn
  uvm_analysis_imp_actual ##(txn, this) analysis_imp_actual; //analysis imp port for actual_txn
  
  typedef txn que_of_t[$]; //queue of txn
  typedef int que_of_idx[$]; //queue of integers (created to store missing indices)
  
  //expected_*
  que_of_t expected_a[int]; //associative array which holds queue of exp data items (indexed by int)
  
  //actual_*
  que_of_t actual_a[int]; //associative array which holds queue of actual data items (indexed by int)
  
  int match, mismatch; //match & mismatch counter
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    analysis_imp_exp=new("analysis_imp_exp");
    analysis_imp_actual=new("analysis_imp_actual");
  endfunction
  
  //analysis_imp function capturing expected txns from predictor (ooo)
  virtual function void write_expected(input txn t);
    //this handle will point to received txn from analysis port (from predictor)
    txn received_txn; //null handle
    
    //cloning the incoming txn for pointer safety 
    //as recieved txn is pushed into queue which might get deleted once use is over
    $cast(received_txn,t.clone());
    
    `uvm_info("SCBD_EXP",$sformatf("recieved_txn: data=%d, addr=%h",received_txn.data,recieved_txn.addr),UVM_MEDIUM)
    
  //main algo to manage, compare, store & delete incoming expected_txn
    compare_or_store_txn(.txn_recv(recieved_txn),.store_q(expected_a),.compare_q(actual_a));
    
  endfunction
  
  //analysis_imp function capturing actual data txns from monitor (actually DUT) (ooo)
  virtual function void write_actual(input txn t);
    
    //this handle will point to recieved_txn from analysis_port (from monitor)
    txn recieved_txn;
    
    //cloning incoming txn for pointer safety
    //as recieved_txn has intent to be modified as it is going to be pushed onto a queue.
    $cast(recieved_txn,t.clone());
    
    `uvm_info("SCBD_ACTUAL",$sformatf("recieved_txn: data=%d, addr=%h",received_txn.data,recieved_txn.addr),UVM_MEDIUM)
    
    //main algo to store or compare incoming recieved_txn
    store_or_compare_txn(.txn_recv(recieved_txn),.store_q(actual_a),.compare_q(expected_a));
    
    
  endfunction
  
  function void store_and_compare_txn(input txn_recv, ref que_of_t store_q[int], ref que_of_t compare_q[int]);
    
    //check if the incoming txn is present already in the queue
    //get_id() is defined in seq_item class
    //if matching item already present in compare_q then comparison will take place in FIFO order(in-order)
    if(compare_q.exists(txn_recv.get_id())) begin:matching_txn_exists
      
      //this bit set means compare was successful
      bit is_equal;
      
      //pop the txn to compare out of the asso array/queue
      //index into asso array holding queue of items & pop queue from front
      txn comparer = compare_q[txn_recv.get_id()].pop_front();
      
      //compare matching items
      is_equal = txn_recv.compare(comparer);
      
      if(!is_equal) begin:exists_but_compare_failed
        
        //txn data mismatched
        mismatch++;
        
        `uvm_error("SCBD_MISMATCH",$sformatf("recived_txn:addr=%h & data=%d mismatched with que txn:addr=%h,data=%d",txn_recv.addr,txn_recv.data,comparer.addr,comparer.data),UVM_MEDIUM)
        
      end:exists_but_compare_failed
      else begin:exists_and_compare_matched
        //txn matched
        match++;
        
        `uvm_info("SCBD_MATCH",$sformatf("recived_txn:addr=%h & data=%d matched with que txn:addr=%h,data=%d",txn_recv.addr,txn_recv.data,comparer.addr,comparer.data),UVM_MEDIUM)
      end:exists_and_compare_matched
      
      //check if more items exist for the same id/index in asso array
      //if not then delete the idx/id from the asso_array
      if(compare_q[txn_recv.get_id()].size() == 0) begin: delete_if_no_more_items_at_idx
        compare_q.delete(txn_recv.get_id());
      end
      
    end:matching_txn_exists
      else begin:matching_txn_not_exist
        
        //if matching txn does not exist & then push is onto the store_q
        store_q[txn_recv.get_id()].push_back(txn_recv);
        
      end: matching_txn_not_exist
    
  endfunction
  
  virtual function int get_matches();
    return match;
  endfunction
  
  virtual function int get_mismatches();
    return mismatch;
  endfunction
  
  virtual function int get_missing_entry_cnt();
    int missing_entry_cnt;
    
    //expected_q (associative array holding expected_q items)
    foreach(expected_q[i]) begin
      missing_entry_cnt+=expected_q[i].size();
    end
    
    //actual_q (associative array holding actual_q items)
    foreach(actual_q[i]) begin
      missing_entry_cnt+=actual_q[i].size();
    end
    
  endfunction
  
  virtual function que_of_idx get_missing_indices();
    que_of_idx missing_idx_q;
    
    //expected_q (associative array holding expected_q items)
    foreach(expected_a[i]) begin
      missing_idx_q.push_back(i);
    end
    
    //actual_q (associative array holding actual_q items)
    foreach(actual_a[i]) begin
      missing_idx.q.push_back(i);
    end
  endfunction
  
  //TODO:Optionally we stuff missing_entry_cnt & missing_indices in check_phase
  
  virtual function report_phase(uvm_phase phase);
    `uvm_info("SCBD_STATS",$sformatf("matches=%d,mismatches=%d,missing_entry=%d,missing_indices=%p",match,mismatch,get_missing_entry_cnt(),get_missing_indices()),UVM_LOW)
  endfunction
  
endclass