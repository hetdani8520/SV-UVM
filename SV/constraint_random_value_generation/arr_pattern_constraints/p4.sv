//SV constraint pattern:- 1221221221221….
//strategy quite same as p3.sv
class p4;
  parameter int N = 12;
  rand bit [2:0] arr[N];
  
  constraint pat {foreach(arr[i]){
    if(i%3 == 0){
      arr[i] == 1;
    }else{
      arr[i] == 2;
    }}}
endclass
      
module test;
  p4 ph;
  initial begin
    ph = new();
    assert(ph.randomize()) else
      $fatal(0,"ranodmization error");
    $display("arr=%p",ph.arr);
  end
endmodule