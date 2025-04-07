//AHB page size constraint on addr to not cross word boundary during burst accesses
//AHB page boundary is 1K bytes I guess (need to cross-ref with amba spec)
/*
AHB has a concept of burst size & burst type.

Problem statement:(Assumptions)
burst size: 0:1byte, 1:2byte, 2:4bytes, 3:8bytes
burst type doesn't exist for the problem (ideally AHB supports SINGLE, INCR4/8/16 & WRAP burst types)

page size(in bytes): 0-15: page 1, 16-31: page 2, 32-47: page 3 etc...

Q. Generate starting address of burst such that it does not cross page size boundary

Ex: start_addr=0x30, burst_size=1 ==> 0x30, 0x31 (LEGAL)
	start_addr=0x30, burst_size=2 ==> 0x30, 0x31, 0x32, 0x33 (ILLEGAL) - constraint solver should reject such combinations
    
*/

class addr_on_page_size_boundary;
  rand bit [31:0] start_addr;
  
  rand bit [2:0] burst_size;
  
  bit [9:0] page_boundary = 16; //16bytes
  
  constraint addr_constraint{
    start_addr + (2^(burst_size) - 1) < (((start_addr/page_boundary) + 1)*page_boundary);
  }
endclass

module tb;
  addr_on_page_size_boundary a1;
  
  initial begin
    a1=new();
    repeat(5) begin    
    assert(a1.randomize()) else
      $fatal(0,"randomization failed");
      $display("start_addr:%h & burst_size=%d",a1.start_addr,a1.burst_size);
    end
  end
endmodule