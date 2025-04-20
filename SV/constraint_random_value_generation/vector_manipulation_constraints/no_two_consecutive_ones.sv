//write a systemverilog constraint such that there are no two consecutive ones in a 16-bit variable

class no_two_consecutive_ones;
  rand bit [15:0] a;
  
  //constraint to make sure two consecutive ones in a 16-bit vector are not ones
  constraint no_contiguous_ones {foreach(a[i]){
    if(i<=14){
      &(a[i+:2]) != 1'b1;}}}
endclass
      
module tb;
  no_two_consecutive_ones c1;
  
  initial begin
    c1=new();
    repeat(5) begin
    assert(c1.randomize()) else
      $fatal(0,"randomization error");
    $display("a=%b",c1.a);
    end
  end
endmodule
