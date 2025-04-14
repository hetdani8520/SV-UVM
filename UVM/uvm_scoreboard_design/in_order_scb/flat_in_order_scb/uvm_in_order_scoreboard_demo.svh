//This in-order scoreboard implementation is copied from the uvmf_base_pkg scb base class template.
//This in-order scoreboard implementation assumes predictor & evaluator/monitor will send txns in order via their respective analysis ports
//This scb captures expected_txn into SV queues to account for any DUT latency.

//uniqufied implementation export renaming done here to prevent function overloading scenario (which is not supported by SV)
`uvm_analysis_impl_decl(_expected) //suffix added to write() imp method from predictor in scb 
`uvm_analysis_impl_decl(_actual)  //suffix added to write() imp method from monitor/evaluator in scb

class uvm_in_order_scoreboard #(type T = tx_item) extends uvm_scoreboard;
  `uvm_component_utils(uvm_in_order_scoreboard#(tx_item))
  
  uvm_analysis_imp_expected #(T, this) expected_analysis_export;
  uvm_analysis_imp_actual #(T, this) actual_analysis_export;
  
  //variables to record matches/mismatches
  int match;
  int mismatch;
  int nothing_to_compare_against;
  
  //variables to delay end of run_phase used in phase_read_to_end
  int wait_for_scb_empty;
  
  //queue for expected_txn. This is required because of DUT latency
  T expected_q[$];
  
  T last_expected;
  T last_actual;
  bit last_mismatched = 0;
  
  //variable to check if scb was used during a test
  int transaction_count;
  
  //variable storing status of scoreboard (enabled/diabled) during a test
  bit enable_scoreboard=1;
  
  
  virtual function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //no need to create  analysis exports with factory as no intention to override
  virtual function build_phase(uvm_phase phase);
    expected_analysis_export=new("expected_analysis_export", this);
    actual_analysis_export = new("actual_analysis_export", this);
    //do a cfg_db get from env_cfg to check if scb should be enabled or disabled
  endfunction
  
  //invoke this function to delay end of run_phase
  virtual function enable_delay_of_scb;
    wait_for_scb_empty=1;
  endfunction
  
  //This triggers when predictor sends an expected txn via its analysis_port
  virtual function void write_expected(input T t);
    if(enable_scoreboard) begin
      //logging usage of scb by a test
      transaction_count++;
      expected_q.push_back(t);
    end
  endfunction
  
  //This triggeres when monitor/agent(for a particular intf) sends an actual txn via its analysis_port
  virtual function void write_actual(input T t);
    T expected_transaction;
    if(scoreboard_enabled) begin : write_actual_imp
      
      //get next entry from exp_q.error if empty
      if(expected_q.size() == 0) begin: nothing_to_compare_against
        //counter increments if no exp_q empty
        nothing_to_compare_against++;
        `uvm_error("SCBD",$sformatf("NO PREDICTED ENTRY TO COMPARE AGAINST:%s",t.convert2string()))
      end: nothing_to_compare_against
      else 
        //entry to compare against exists
        begin: entry_to_compare_exists
          expected_transaction = expected_q.pop_front();
          
          //compare actual txn to expected txn
          last_expected = expected_transaction; //no need to clone here as no modification intent
          last_actual = t; //no need to clone here as no modification intent
          if(t.compare(last_expected)) //last_expected or expected_transaction?
            begin: match_pass
              match++;
              last_mismatched=0;
              `uvm_info("SCBD",compare_message("MATCH! - ",expected_transaction,t),UVM_MEDIUM)
            end: match_pass
          else
            begin: match_fail
              mismatch++;
              last_mismatched = 1;
              `uvm_error("SCBD",compare_message("MISMATCH! - ",expected_transaction,t))
            end: match_fail       
        end: entry_to_compare_exists
    end :write_actual_imp
    
  endfunction:write_actual
  
  virtual function void wait_for_scb_to_drain(uvm_phase phase);
    wait(expected_q.size == 0);
    phase.drop_objection(this,"phase_ready_to_end");
  endfunction
  
  //implement the phase_ready_to_end_method to delay the end of run_phase
  virtual function void phase_ready_to_end(uvm_phase phase);
  if(phase.get_name() == "run") begin
    if(expected_q.size() == 0) return;
    phase.raise_objection(this,"phase_ready_to_end");
    fork
      wait_for_scb_to_drain(phase);
    join_none
    end
  endfunction
  
endclass
