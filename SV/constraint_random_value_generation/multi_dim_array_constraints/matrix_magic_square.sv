//a square array of numbers, usually positive integers, is called a magic square if the sums of the numbers in each row, each column, and both main diagonals are the same.[1][2] The "order" of the magic square is the number of integers along one side (n), and the constant sum is called the "magic constant"

/*Ideal output:
          0:  4	  2	  9	
          1: 10	  5	  0	
          2:  1	  8	  6	

*/

class magic_square;
  parameter int N = 3;
  
  rand bit [7:0] magic_square[N][N];
  
  constraint row_col {
    //row
    foreach(magic_square[i]){
    magic_square[i].sum(row) with (int'(row)) == 15;
  }
    //col constraint
    foreach(magic_square[,j]){
    magic_square.sum(row) with (row.sum(col) with (col.index == j ? int'(col):0))  == 15;
    }}
  
  //diagonal constraint
  constraint diag_constraint{
    magic_square.sum(row) with (row.sum(col) with (row.index == col.index ? int'(col):0)) == 15;}
      
  //anti-diagonal constraint
  //how to identify where they are located => i+j = $size(magic_square) - 1;
  constraint ant_diag_constraint{
    magic_square.sum(row) with (row.sum(col) with (row.index + col.index == N -1 ? int'(col):0)) == 15;}
  
endclass
    
module tb;
  magic_square m1;
  initial begin
  m1=new();
  
  assert(m1.randomize()) else 
    $fatal(0,"randomization::error failed");
  
  foreach(m1.magic_square[i]) begin
    $write("%d:",i);
    foreach(m1.magic_square[,j]) begin
      $write("%d\t",m1.magic_square[i][j]);
    end
    $display;
  end
  end
endmodule