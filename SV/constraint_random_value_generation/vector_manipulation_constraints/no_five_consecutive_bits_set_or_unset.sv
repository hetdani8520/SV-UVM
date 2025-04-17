// systemverilog constraint to not have 5 contiguous bits set or unset in a 32-bit variable.

class no_five_consecutive_bits_set_or_unset;
  rand bit [31:0] a;
  
  constraint no_more_than_5 {foreach(a[i]){
    if(i<=27){
      !(&(a[i+:5])); //not see 5 contiguous bits set
      !(&(~a[i+:5]));}}} //not see 5 contiguous bits unset
    							
endclass
      
module tb;
  no_five_consecutive_bits_set_or_unset c1;
  
  initial begin
    c1=new();
    assert(c1.randomize()) else
      $fatal(0,"randomization error");
    $display("a=%b",c1.a);
      
  end
endmodule