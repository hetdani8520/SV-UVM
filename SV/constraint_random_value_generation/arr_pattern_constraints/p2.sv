//Write a constraint to generate the pattern 123123123123.
class p2;
  parameter int N = 12;
  rand bit [5:0] arr[N];
  
  constraint pat {foreach(arr[i]){
    arr[i] == (i%3) + 1;}} //i%3 constraints the value to be between 0 to 2
endclass
    
module test;
  p2 ph;
  initial begin
    ph = new();
    assert(ph.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",ph.arr);
  end
endmodule