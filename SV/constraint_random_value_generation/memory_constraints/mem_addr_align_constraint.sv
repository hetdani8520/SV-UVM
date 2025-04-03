//write a systemverilog constraint such that 32-bit addr is half_word aligned
//write a systemverilog constraint such that 32-bit addr is word-aligned
//write a systemverilog constraint such that addr is within 4k boundary

//by default all memory addresses are byte-aligned

class mem_addr_align_constraint;
  rand bit [31:0] addr;
  
  //2-byte aligned
  //constraint half_word_align_cons {addr % 2 == 0;} //2byte => addr[0] == 0
  
  //4-byte aligned
  //constraint word_aligned_constraint {addr % 4 == 0;} //4bytes => 2^2 bytes = addr[1:0] == 0
  
  //4K-byte aligned
  constraint align_4k_cons {addr[11:0] == 0;} //4Kbytes => 2^12 bytes = addr[11:0] == 0
endclass

module tb;
  mem_addr_align_constraint m1;
  
  initial begin
    m1=new();
    repeat(5) begin
    assert(m1.randomize()) else
      $fatal(0,"Randomization::m1::error");
    
    $display("random aligned addr(bin)=%b & random aligned addr(hex)=%h ",m1.addr,m1.addr);
    end
  end
  
  
endmodule