//38. How to randomize a 2D array in SystemVerilog with each column
//sorted?

class arr_2d_col_only_sort;
  
  parameter int N = 3;
  rand bit [4:0] arr[N][N];
  
  
  //arr column constraint
  constraint column {foreach(arr[i]){
    foreach(arr[,j]){
      if(i<2){
        arr[i][j] < arr[i+1][j];}}}} //iterating over column
  
  
endclass
      
module test;
  arr_2d_col_only_sort a1;
  
  initial begin
    a1=new();
    assert(a1.randomize()) else
      $fatal(0,"randomization error");
    
    foreach(a1.arr[i]) begin
      $write("%d:",i);
      foreach(a1.arr[,j]) begin
        $write("%d\t",a1.arr[i][j]);
      end
      $display;
    end
    
    //$display("arr=%p",a1.arr);
  end
endmodule