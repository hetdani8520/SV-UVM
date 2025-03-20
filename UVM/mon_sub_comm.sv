//mon -subscriber commmunication using analysis port - analysis/implementation export
//subscriber1 broadcasts all the data from monitor
//subscriber2 only wakes up & does analysis when the broadcasted data on monitor is 0
//The argument to the analysis_port is txn HANDLE & NOT txn object. txn object is created only once & handle is passed around through monitor to all the concerned subscribers
//monitor
class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor)
  
  bit [7:0] a;
  
  uvm_analysis_port #(bit [7:0]) ap;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    ap=new("analysis_port",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
  for(int i=0;i<=10;i++) begin
    a=$urandom_range(0,255);
    ap.write(a);
  end
  endtask
endclass
  
//subscriber1
//analysis export object need not be created, already handled in uvm_subscriber parent class
class sub1 #(type T =bit [7:0]) extends uvm_subscriber #(T);
  `uvm_component_utils(sub1)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void write(T arg);
    //do analysis of broadcasted data from monitor
    `uvm_info("SUB1",$sformatf("got txn from monitor:%d",arg),UVM_LOW)
  endfunction
  
endclass

//subscriber2 (This subscriber wakes up & does analysis only when broadcasted data from monitor is 0)
//analysis export object need not be created, already handled in uvm_subscriber parent class
class sub2 #(type T =bit [7:0]) extends uvm_subscriber #(T);
  `uvm_component_utils(sub2)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void write(T arg);
    //do analysis if broadcasted data from monitor = 0
    if(arg == 'd0) begin
      `uvm_info("SUB2",$sformatf("Broadcasted data from monitor is 0:%d",arg),UVM_LOW)
    end
  endfunction
  
endclass

class tx_test extends uvm_test;
  `uvm_component_utils(tx_test)
  
  sub1 s1;
  sub2 s2;
  tx_monitor m1;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    s1=sub1#(bit[7:0])::type_id::create("s1",this);
    s2=sub2#(bit[7:0])::type_id::create("s2",this);
    m1=tx_monitor::type_id::create("m1",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    //initiator.port.connect(target.export)
    
    //connecting monitor analysis port with subscriber1 analysis_export/imp_export
    m1.ap.connect(s1.analysis_export);
    
        //connecting monitor analysis port with subscriber2 analysis_export/imp_export
    m1.ap.connect(s2.analysis_export);
  endfunction
  
    virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("TX_TEST",$sformatf("inside tx_test"),UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass

module mon_sub_comm;
  initial begin
    run_test("tx_test");
  end
endmodule