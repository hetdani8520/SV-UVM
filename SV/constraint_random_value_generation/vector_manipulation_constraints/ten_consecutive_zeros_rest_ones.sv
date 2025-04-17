//Credits for problem statement:- https://debug.beehiiv.com/p/hard-another-constraint-challenge-09b3
//Write a System Verilog constraint to generate a random 32-bit value with 10 contiguous bits as 0 and the remainder of the bits as 1

class ten_consecutive_zeros_rest_ones;
  rand bit [31:0] a;
  rand bit [4:0] start_idx;
  
  
  constraint iterator_constraint {start_idx <= 22;}
  
  constraint ten_consecutive_zeros {(|a[start_idx+:10]) == 0;} //random 10 bits zeros based on randomized start_idx value
    
  constraint rest_bits_ones {$countones(a) == 22;} //10 zeros means 22 ones
  
endclass
    
module test;
  ten_consecutive_zeros_rest_ones t1;
  
  initial begin
    t1=new();
    assert(t1.randomize()) else
      $fatal(0,"randomization error");
    $display("a=%b",t1.a);
  end
  
endmodule