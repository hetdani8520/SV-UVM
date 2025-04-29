//38. How to randomize a 2D array in SystemVerilog with each row
//sorted?

class arr_2d_row_sort;
  rand bit [4:0] arr[3][3];
  
  //constrain arr size
  //constraint arr_size {$size(arr,1) == 3;
                       //$size(arr,2) == 3;}
  
  //arr row constraint
  constraint row {foreach(arr[i]){
    foreach(arr[,j]){
      if(j<2){
        arr[i][j] < arr[i][j+1];}}}} //iterating over row
  
  
endclass
      
module test;
  arr_2d_row_sort a1;
  
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
  end
endmodule