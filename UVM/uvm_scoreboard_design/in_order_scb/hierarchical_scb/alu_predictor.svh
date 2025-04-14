//any component extending from uvm_subscriber comes with a built-in analysis_export 
class alu_predictor extends uvm_subscriber #(alu_txn);
//factory regs & constructor

//port to send out expected predicted result into an evaluator
uvm_analysis_port #(alu_txn) expected_port;

virtual function void build_phase(uvm_phase phase);
expected_port = new("expected_port",this);
endfunction

//implementation of write() method called by monitor using analysis_port
virtual function void write(input alu_txn t);
alu_txn expected_txn;
//clone the input txn & copy it into expected txn as the same txn from monitor might also be sent to cov collector & we don't want to share stale info to other components
if(!($cast(expected_txn,t.clone()))) `uvm_fatal()
//prediction logic
case(t.opcode):
ADD: expected_txn.result = t.a + t.b;
SUB: expected_txn.result = t.a - t.b;
...
endcase
//sending the txn to evaluator via analysis_port
expected_port.write(expected_txn);
endfunction

endclass