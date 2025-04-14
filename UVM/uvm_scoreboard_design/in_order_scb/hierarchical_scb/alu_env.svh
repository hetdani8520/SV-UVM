class alu_env extends uvm_env;
//factory regs & constructor

alu_scoreboard scb;
alu_agent agt;

virtual function void build_phase(uvm_phase phase);
scb = alu_scoreboard::type_id::create("scb", this);
agt - alu_agent::type_id::create("agt", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
agt.dut_in_port.connect(scb.dut_in_export);
agt.dut_out_port.connect(scb.dut_out_export);
endfunction
endclass