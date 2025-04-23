//Parallel sequence gotchas

class multi_test extends uvm_test;
  //factory regs & constructor
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this,"raise obj");
    two_vseq.init_start(agt_cfg);
    phase.drop_objection(this, "drop obj");
  endtask
endclass

class two_vseq extends uvm_sequence;
  //factory regs & constructor
  agt_config agt_cfg;
  virtual task init_start(input agt_config agt_cfg);
    this.agt_cfg = agt_cfg;
    this.start(null); //start vseq on null sqr
  endtask
  
  //start child sequences here
  virtual task body();
    //Here the assumption is both sequences running on same sqr is not an issue (can be handled by choosing right arb policy & priority weights)
    //The main problem here is the noise_seq runs forever, which could result in this sequence never returning back control to the test...
    fork
      main_seq.start(agt_cfg.sqr, this); //This finishes are 100 txns are generated
      noise_seq.start(agt_cfg.sqr, this); //This runs inside a forever loop
    join_any
    noise_seq.stop = 1; //This flag sets once main seq is finished the fork joins (This flag when set will be a timeout for noise seq to return cleanly w/o locking up sqr)
  endtask
endclass

//ideally the noise seq should run as long as main sequence but not longer
class noise_seq extends uvm_sequence;
  bit stop=0;
  task body();
    forever begin
      if(stop) return; //cleanly exit
    tx = tx_item::type_id::create("tx", this);
      start_item(tx);
      assert(tx.randomize()) else
        `uvm_fatal("RANDERRSEQ","randomization error");
      finish_item(tx);
    end
endclass
    
    
    //If fork..join is used in two_vseq to spawn two child sequences, due to noise seq running forever, the seq may never return & hence never join & hence the test may hang (because objection was not dropped) & eventually terminate simulation if global timeout is met.
    
    //If fork...join is used in two_vseq to spawn two child sequences, the child sequences will be scheduled for execution but does not start executing unless there is a blocking statement in parent thread, which will more likely cause none of the sequences to even run before the test terminates/drops objection. So we basically went from running forever or sending too many seq_items (using fork..join) to not even running one or sending none seq_items (using fork..join_none)
    
    //If fork..join_any is used iin two_vseq to spawn two child sequences, the fork..join_any is great to model a timeout in a system. The main_seq completes after running lets say 100 txns & fork..joins & noise_seq keeps running forever in background w/o blocking parent thread. But we need to kill-off that noise seq & not let it run anymore.
    //If we use disable fork to kill off the remaining thread following join_any, that might kill the noise_seq midway causing sqr to lock up in some stale state. This will not be a problem if our vseq is not intended to be resused. If it is intended to be resused then we wouldn't want to leave sqr in stale state when used by some other user. So to work around that problem, we can do the following approach:
    //1)lets try to tell the noise seq to finish cleanly
    //2)we can create a property called "stop" in noise seq which will check the status of itself at the beginning of forever loop & check if it should stop & return.
    //3)The flag stop could be set immediately after join_any. This will tell the noise_seq to complete whatever it is doing currently & then stop the seq cleanly (w/o leaving sqr in bad state) & return control eventually to test which will then drop objection & terminate simulation cleanly.
    