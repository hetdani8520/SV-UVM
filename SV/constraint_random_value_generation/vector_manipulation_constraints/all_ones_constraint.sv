//systemverilog constraint to generate all ones in a vector

class all_ones;
  parameter int N = 16;
  rand bit [N-1:0] a;
  
  //method-1 ($countones)
  constraint all_ones_1 {$countones(a) == N;}
  
  //method-2 (foreach)
  constraint all_ones_2 {foreach(a[i]){
    a[i] == 1;}}
    
  
  //method-3 (bitwise op)
  constraint all_ones_3 {&(a[0+:N]) == 1;}
  
  //method-4 (power of 2)
  constraint all_ones_4 {a == ((2**N) - 1);}
  
  //method-5 (left-shift operator) [2**16 == 1<<N] 
  constraint all_ones_5 {a == (1 << N) - 1;}
  
  //method-6 (replication operator)
  constraint all_ones_6 {a == {N{1'b1}};} //you need to size replicated value as unsized constraints are defaulted to 32-bits
  
  //method-7 (signed-unsigned hack)
  /* (16-bit var signed range = -8 to +7)
  0 - 0 
  1 - 1
  2 - 2
  3 - 3
  4 - 4
  5 - 5
  6 - 6
  7 - 7

  8 - (-8)
  9 - (-7)
  10 - (-6)
  11 - (-5)
  12 - (-4)
  13 - (-3)
  14 - (-2)
  15 - (-1)
  */
  constraint all_ones_7 {a == -(16'd1);}
  
  //method-8 (negation unary operator)
  constraint all_ones_8 {a == ~(16'd0);}
  
  //method-9 (sum() method) - not feasible (you cannot apply sum() on vectors)
  //Array manipulation methods can be applied to unpacked arrays or queues only
endclass


module test;
  all_ones a1;
  
  initial begin
    a1=new();
    //disable all constraints
    a1.constraint_mode(0);
    
    //enable any one constraint
    a1.all_ones_4.constraint_mode(1);
    
    assert(a1.randomize()) else
      $fatal(0,"randomization error");
    $display("a=%b",a1.a);
  end
endmodule