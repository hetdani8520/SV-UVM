//Write a constraint to generate the pattern 100100100100.
class p3;
  parameter int N = 12;
  rand bit [2:0] arr[N];
  
  constraint pat {foreach(arr[i]){
    //%3(modulo 3) is because pattern starts repeating itself after every 3 numbers (result of modulo 3 will be between 0 to 2)
    if(i%3 == 0){ 
      arr[i] == 1;
    }else{
      arr[i] == 0;
    }}}
endclass
      
module test;
  p3 ph;
  initial begin
    ph = new();
    assert(ph.randomize()) else
      $fatal(0,"ranodmization error");
    $display("arr=%p",ph.arr);
  end
endmodule