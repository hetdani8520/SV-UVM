//Credits to ChipVerify for problem statement & soln
// Burst [ 0 -> 1 byte, 1 -> 2 bytes, 2 -> 3 bytes, 3 -> 4 bytes] (burst size)
// Length -> max 8 transactions per burst (burst type)
// Protocol expects to send only first addr, and slave should calculate all
// other addresses from burst and length properties

//Notes:
//length/burst type(SINGLE/INCR4/8/16): number of transfers in a burst
//burst/burst_size(2/4/8/16 bytes): size of a particular transfer in a burst
//end_addr = start_addr + (burst_size + 1)*(burst_len + 1) - 1;// +1 is because the encoding starts from 0. encoding of 0 maps to 1byte burst size.

class bus_addr_constraint;
  rand bit [1:0] burst_size; //burst size (size of each burst) [0,1,2,3]
  rand bit [2:0] burst_type; //burst len (number of transfers in a burst) [upto 8 max transfers)
  
  rand bit [31:0] master_start_addr;
  
  rand bit [31:0] master_wdata;
  
  constraint word_align {master_start_addr % 4 == 0;}
  
  function void bus_txn_disp(int idx = 0);
    $display ("------ Transaction %0d------", idx);
    $display (" master_start_addr 	= 0x%0h", master_start_addr);
    $display (" master_wdata 	= 0x%0h", master_wdata);
    $display (" Burst_size 	= %0d bytes/xfr", burst_size + 1);
    $display (" burst_type  = %0d", burst_type + 1);
  endfunction
 
  
endclass

module tb;
  bus_addr_constraint b1;
  int slave_start_addr;
  int slave_end_addr;
  
  initial begin
    //slave target addr range set b/w 0x00 to 0xFF (256bytes)
  slave_start_addr = 32'h00000000;
  slave_end_addr = 32'h000000FF;
    b1=new();
    
    assert(b1.randomize() with {master_start_addr >= slave_start_addr;
                                 master_start_addr < slave_end_addr;
                                 master_start_addr + (burst_size + 1)*(burst_type + 1) < slave_end_addr;}) else
      $fatal(0,"randomization error");
    b1.bus_txn_disp();
    
  end
endmodule