//virtual sequence on multiple agents
//-->a virtual sequence can start multiple sequences in parallel
//-->each sequence is associated with a diff agent sequencer

//---------------------------------------------------------------------
//The below strategy passes sqr handles (from resp agent sequencers) via cfg_obj as argument to init_start method()
//Alternatively, one can also just pass resp agt_cfg obj handles as arg to init_start() method & further sequences can run on resp agent sqr using cfg_obj handle in vseq.

class ahb_and_spi_seq extends uvm_sequence;
  //factory regs & constructor
  
  uvm_sequencer #(ahb_item) ahb_sqr;
  uvm_sequencer #(spi_item) spi_sqr;
  
  virtual task init_start(input uvm_sequencer #(ahb_item) ahb_sqr, input uvm_sequencer ##(spi_item) spi_sqr);
    this.ahb_sqr = ahb_sqr;
    this.spi_sqr = spi_sqr;
    this.start(null); //vseq starts on null sqr
  endtask
  
  ahb_sequence ahb_seq;
  spi_sequence spi_seq;
  
  virtual task body();
    ahb_seq = ahb_sequence::type_id::create("ahb_seq", this);
    spi_seq = spi_sequence::type_id::create("spi_seq", this);
    fork
      //there is no conflict b/w the below two sequences as they are associated with diff sequencers in diff agents
      ahb_seq.start(ahb_sqr);
      spi_seq.start(spi_sqr);
    join
  endtask
endclass

//test_base class will be where all env/agt config objects will be instanced & set in cfg_db
class ahb_spi_test extends test_base;
  //factory regs & constructor
  ahb_and_spi_seq vseq;
  virtual task run_phase(uvm_phase phase);
    vseq = ahb_and_spi_seq::type_id::create("vseq", this);
    phase.raise_objection(this,"raise obj");
    //the cfg obj will be created in test base class & sqr handle assignment will happen in resp agent's build_phase()
    vseq.init_start(ahb_cfg.sqr,spi_cfg.sqr);
    phase.drop_objection(this,"drop obj");
  endtask
endclass