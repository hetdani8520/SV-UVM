class alu_txn extends uvm_sequence_item;
//factory regs & constructor

rand OPCODE_t opcode;
rand  bit [15:0] a,b;
logic [16:0] result; 
...


endclass