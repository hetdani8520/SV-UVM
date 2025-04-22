//virtual sequence wr_rd_seq which starts wr_seq & rd_seq
//(single agent/interface configuration)
class wr_rd_seq extends uvm_sequence;
  ahb_config ahb_cfg;
  //init_start method
  virtual task init_start(input ahb_config ahb_cfg);
    this.ahb_cfg = ahb_cfg;
    this.start(null); //vseq doesnt need a sequencer
  endtask
  
  virtual task body();
    writeN_sequence seq_wr;
    read_all_sequence seq_rd;
    
    seq_wr = writeN_sequence:::type_id::create("seq_wr");
    seq_wr.start(ahb_cfg.sqr, this);
    
    seq_rd = read_al_sequence::type_id::create("seq_rd");
    seq_rd.start(ahb_cfg.sqr, this);
    
  endtask
endclass

//How to get ahb_cfg handle into a sequence?
//By getting it into test class using agt cfg_object
class ahb_test extends ahb_test_base;
  //factory regs & constructor
  
  wr_rd_seq vseq;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase); //this will create a cfg_obj & set the ahb_cfg object in cfg_db
    //create vseq object
    vseq = wr_rd_seq::type_id::create("vseq");
    phase.raise_objection(this,"start obj");
    vseq.init_start(ahb_cfg); //ahb_cfg handle will be set & created in ahb_test_base class
    phase.drop_objection(this, "end obj");
  endtask
endclass