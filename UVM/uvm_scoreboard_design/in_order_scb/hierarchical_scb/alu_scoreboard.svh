//With hiearchical approach scoreboard is just a container class
class alu_scoreboard extends uvm_scoreboard;
//factory regs & constructor
alu_predictor predictor;
alu_evaluator evaluator;

//export to imp_export in the predictor
uvm_analysis_export #(alu_txn) dut_in_export;

//export to imp export in the evaluator
uvm_analysis_export #(alu_txn) dut_out_export;

virtual function build_phase(uvm_phase phase);
dut_in_export = new("dut_in_export", this);
dut_out_export = new("dut_out_export", this);
predictor = alu_predictor::type_id::create("predictor", this);
evaluator = alu_evaluator::type_id::create("evaluator", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
//analysis export-export connection from parent(scoreboard) to child(predictor)
dut_in_export.connect(predictor.analysis_export);
//analysis export-export connection from parent(scoreboard) to child(evaluator)
dut_out_export.connect(evaluator.actual_export);
//analysis_port - export connection between broadcaster(predictor) & subscriber(evaluator/analysis_fifo) 
predictor.expected_port.connect(evaluator.expected_export);
endfunction

endclass