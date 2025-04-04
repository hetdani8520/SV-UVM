//Assume we have a 2KB SRAM in the design intended to store some data. Let's say that we need to find a block of addresses within the 2KB RAM space that can be used for some particular purpose.
//Pick a random memory block within the RAM (block size randomized between 64,512 & 128 bytes)
class mem_partition_basic;
  
  bit [31:0] ram_start;
  bit [31:0] ram_end;
  
  rand bit [31:0] start_addr;
  rand bit [31:0] end_addr;
  rand bit [31:0] block_size;
  
  //start address should be word-aligned
  constraint align {start_addr % 4 == 0;}
  
  //start addr should be greater than or equal to RAM start addr
  //end addr should be lesser than RAM end addr
  //end addr should be start_addr + block_size - 1
  constraint addr {start_addr >= ram_start;
                    end_addr < ram_end;
                    start_addr + block_size - 1 == end_addr;}
  
  constraint c_blk_size { block_size inside {64, 128, 512 }; }; 	// Block's size should be either 64/128/512 bytes
  
  function void display();
    $display ("------ Memory Block --------");
    $display ("RAM StartAddr   = 0x%0h", ram_start);
    $display ("RAM EndAddr     = 0x%0h", ram_end);
	$display ("Block StartAddr = 0x%0h", start_addr);
    $display ("Block EndAddr   = 0x%0h", end_addr);
    $display ("Block Size      = %0d bytes", block_size);
  endfunction
  
endclass

module tb;
  mem_partition_basic m1;
  
  initial begin
    m1=new();
    m1.ram_start = 32'h0;
    m1.ram_end = 32'h7FF;
    assert(m1.randomize()) else
      $fatal(0,"Randomization error");
    m1.display();
  end
endmodule