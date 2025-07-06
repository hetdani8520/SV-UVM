//Write a constraint to generate the pattern 1234554321.
class p1;
  parameter int N = 10;
  rand bit [5:0] arr[N];
  
  constraint pat {foreach(arr[i]){
    if(i<5){
      arr[i] == i + 1;
    }else {
      arr[i] == (10 - i);
    }}}
endclass
      
module test;
  p1 ph;
  initial begin
    ph=new();
    assert(ph.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",ph.arr);
  end
endmodule