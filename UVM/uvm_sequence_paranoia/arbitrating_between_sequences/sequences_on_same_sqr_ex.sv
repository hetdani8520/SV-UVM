class dual_ahb_vseq extends uvm_sequence;
  //The sqr decides which seq_item to pass to the driver
  uvm_sequencer #(ahb_item) sqr; // this will be assigned the handle to agt sqr either via cfg object/init_start()
  
  ahb_sequence ahb_seq1;
  ahb_sequence ahb_seq2;
  
  virtual task body();
    //set the arb policy for the sqr to use (default if not set - UVM_SEQ_ARB_FIFO)
    sqr.set_arbitration(UVM_SEQ_ARB_WEIGHTED)
    ahb_seq1 = ahb_sequence::type_id::create("ahb_seq1', this);
    ahb_seq2 = ahb_sequence::type_id::create("ahb_seq2', this);
    //seq1 seq_items are picked more often than seq2 seq_items due to priority weight & chosen sqr arb policy
    fork
      ahb_seq1.start(sqr, this, 200);
      ahb_seq2.start(sqr, this, 200);
    join
  endtask
endclass