//Have phase_to_ready_end function implementation in your scb if you are expected DUT delays at the end of run_phase().
class scoreboard extends uvm_scoreboard;
  //factory reg
  
  //queue to record expected txn from predictor 
  tx_item expected_q[$];


  // This function is executed at the end of the run_phase.  
  // It allows the simulation to continue so that remaining transactions on the scoreboard can be removed.
virtual function void phase_ready_to_end(uvm_phase phase);
  if(phase.get_name() == "run")
  
    if(expected_q.size() == 0) return; //Any txn left (if not return)
  //raise objection if expected_q size non-zero)
  phase.raise_objection(this,"phase_ready_to_end");
  fork
    wait_for_scoreboard_to_drain(phase); //calling a task from function by spawning a thread in background
  join_none
  
endfunction
  
    // This task is used to implement a mechanism to delay run_phase termination to allow the scoreboard time to drain.  
  // Extend a scoreboard to override this task based on project requirements.  The delay mechanism can be for instance 
  // a mechanism that ends when the last entry is removed from the scoreboard.
  virtual task wait_for_scoreboard_to_drain(uvm_phase phase);
    wait(expected_q.size == 0);
    phase.drop_objection(this,"phase_ready_to_end");
  endtask
    
endclass