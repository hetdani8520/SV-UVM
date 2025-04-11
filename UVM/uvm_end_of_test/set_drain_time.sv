//implement drain time in your base test & extend from it for other tests & invoke super.run_phase(phase) in all the tests to set the drain time as defined in tx_test_base
//set_drain_time() will delay the end of run_phase after the last dropped objection by the time specified as second arg in the set_drain_method() method
//you can even have this in end_of_elab phase()
class tx_test_base extends uvm_test;
  //factory reg
  
  //new
  
  //build_phase
  
  extern virtual task run_phase(uvm_phase phase);
  
endclass
  
task tx_test_base::run_phase(uvm_phase phase);
  phase.phase_done_set_drain_time(this,100ns); //drain time set to 100ns
endtask