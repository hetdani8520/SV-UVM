//evaluator compares expected & actual txns
//uses analysis_fifo for both expected & actual txn.
class alu_evaluator extends uvm_component;
//factory regs & constructor

//analysis_export to get expected txn
uvm_analysis_export #(alu_txn) expected_export;
//tlm_fifo to store expected_txxn from predictor
uvm_tlm_analysis_fifo #(alu_txn) expected_fifo;

//analysis_export to get actual txn
uvm_analysis_export #(alu_txn) actual_export;
//tlm_fifo to store actual_txn from predictor
uvm_tlm_analysis_fifo #(alu_txn) actual_fifo;

int match, mismatch;

virtual function void build_phase(uvm_phase phase);
expected_export=new("expected_export"", this);
expected_fifo=new("expected_fifo", this);
actual_export=new("expected_export"", this);
actual_fifo=new("expected_fifo", this);
endfunction

//connect analysis_export to respective fifo exports
virtual function void connect_phase(uvm_phase phase);
expected_export.connect(expected_fifo.analysis_export);
actual_export.connect(actual_fifo.analysis_export);
endfunction

//analysis export feeds into the analysis FIFO
//The FIFO implements a write() method to put() data in and get() to read it out
virtual task run_phase(uvm_phase phase);
forever begin
alu_txn expected_txn, actual_txn;
expected_fifo.get(expected_txn);
actual_fifo.get(actual_txn);
if(actual_txn.compare(expected_txn))
match++;
else begin
`uvm_error("Evaluator",$sformatf("%s does not match %s",expected_txn.convert2string(),actual_txn.convert2string()))
mismatch++;
end
end
endtask

//report status of evaluator at the end of simulation 
function void report_phase(uvm_phase phase);
`uvm_info("Evaluator",$sformatf("Passed=%d, Failed=%d",match,mismatch),UVM_LOW)
endfunction

endclass