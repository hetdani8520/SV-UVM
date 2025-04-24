//4)	I have a 2x16 2d matrix like this:
//[ 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0
//0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0]
//I have row constraint that ensures that there aren’t more than 2 1s in the same row.
//I want to write a column constraint such that the there is never 2 1s in the same column.

class two_x_16_matrix;
  parameter int N = 2;
  parameter int M = 16;
  
  rand bit [1:0] arr[N][M];
  
  constraint elem {foreach(arr[i,j]){
    arr[i][j] inside {0,1};}}
  
  //This constraint makes sure that there are no more than 2 1's in every row  
  constraint row_cons {foreach(arr[i]){
    arr[i].sum(row) with (int'(row == 1)) <= 2;}}
    
    //This constraint makes sure that there are never exactly 2 1's in every column 
    constraint col_cons {foreach(arr[,j]){
      arr.sum(row) with (row.sum(col) with (col.index == j ? int'(col==1):0)) != 2;}
endclass
    
    
    
module tb;
  two_x_16_matrix t1;
  
  initial begin
    t1=new();
    assert(t1.randomize()) else
      $fatal(0,"randomization error");
    foreach(t1.arr[i]) begin
      $write("%d:",i);
      foreach(t1.arr[,j]) begin
        $write("%d",t1.arr[i][j]);
      end
      $display;
    end
  end
endmodule

