//The below snippet shows test configuration (like vif, config vars) passed through cfg objects (env_cfg & agt_cfg) via cfg_db to the monitor/driver etc.

//In this example we focus on sending vif  handle from tb_top into monitor using cfg_objects via cfg_db get() & set()

//This code is for understanding purposes (this is a pseudocode - doesn't intend to simulate)


//usb_agt config object (cfg_objects)
class usb_config extends uvm_object;
  //factory regs & constructor
  
  virtual usb_interface vif;
  uvm_active_passive_enum active = UVM_ACTIVE;
  //some test cfg bit (optional)
endclass

//env config object (cfg_objects)
class env_config extends uvm_object;
  usb_config usb_cfg;
  bit enable_scoreboard=0;
  bit enable_coverage=0;
endclass

//USB_TEST class
class usb_test extends uvm_test;
  //factory regs & constructor
  env_config env_cfg; //handle to env_cfg object
  usb_config usb_cfg; //handle to agt cfg object
  usb_env env;        //handle to usb env
  
  //when build_phase of test is called at that point there is only one entry in cfg_db which has vif & which was set in tb_top
  virtual function void build_phase(uvm_phase phase);
    //create env_cfg object
    env_cfg=env_config::type_id::create("env_cfg");
    //create agt_cfg object(usb_cfg)
    usb_cfg=usb_config::type_id::create("usb_cfg");
    //connect env_cfg with agt_cfg (optional I guess)
    env_cfg.usb_cfg = usb_cfg;
    //set the scoreboard enable to 1
    env_cfg.enable_scoreboard = 1;
    
    //pass the above env_cfg info into cfg_db for env to get() when it wakes up
    //The scope set as => this.env =>uvm_test_top.env can get()
    uvm_config_db#(env_config)::set(this,"env","env_cfg",env_cfg);
    
    //get the vif from top_hdl/top_tb
    if(!uvm_config_db#(virtual usb_interface)::get(this,"","usb_if",usb_cfg.vif))
      `uvm_fatal("NOVIF","no vif in db");
    
    //create the env
    env = usb_env::type_id::create("env", this);
    
  endfunction
endclass

//USB_ENV class
class usb_env extends uvm_env;
  //factory regs & constructor
  
  env_config env_cfg;
  usb_agt agt;
  usb_scb scb;
  
  //Guidelines:
  //1)Initialize the configuration at test level
  //2)add handles to uvm_cfg_db one level at a time
  
  virtual function void build_phase(uvm_phase phase);
    //get the env_cfg from cfg_db in usb_env
    if(!uvm_config_db#(env_config)::get(this,"","env_cfg",env_cfg))
      `uvm_fatal("NOVIF","no entryy in db found");
    
    //put agent usb_config handle into cfg_db for agent & sub-components
    uvm_cfg_db#(usb_config)::set(this,"agt*","usb_cfg",env_cfg.usb_cfg);
    
    //construct a usb_agt
    agt = usb_agt::type_id::create("agt",this);
    
    //construct a usb_scb
    if(env_cfg.enable_scoreboard == 1) begin
      scb=usb_scb::type_id::create("scb",this);
    end
    
  endfunction
endclass
  

  //USB_AGT class
  class usb_agt extends uvm_agent;
    //factory regs & constructor
    
    usb_monitor mon;
    usb_drv drv;
    uvm_sequencer #(usb_item) sqr;
    usb_config usb_cfg;
    
    virtual function void build_phase(uvm_phase phase);
      //get the usb_cfg for agent from cfg_db
      if(!uvm_config_db#(usb_config)::get(this,"","usb_cfg",usb_cfg))
        `uvm_fatal("NOCFG","usb_cfg not found in cfg_db");
      
      //check if agt active then create drv & sqr
      if(usb_cfg.active == UVM_ACTIVE) begin
        drv=usb_drv::type_id::create("drv",this);
        sqr=uvm_sequencer::type_id::create("sqr");
      end
      
    endfunction
    
  endclass

class usb_mon extends uvm_monitor;
  //factory regs & constructor
  
  virtual usb_interface vif;
  usb_config usb_cfg;
  
  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(usb_config)::get(this,"","usb_cfg",usb_cfg))
      `uvm_fatal("NOVIF","no entry found in config db");
    //vif handle copied from agt cfg object into monitor
    vif = usb_cfg.vif;
  endfunction
endclass