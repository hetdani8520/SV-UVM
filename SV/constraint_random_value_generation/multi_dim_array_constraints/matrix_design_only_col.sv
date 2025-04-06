//Problem statement:place N number of ones in a 2d-array such that each column has a maximum of only one 1s.
/*
Output:-
0:0	0	1	0	1	0	0	0	
1:0	0	0	0	0	0	0	0	
2:0	0	0	0	0	1	0	1	
3:1	0	0	0	0	0	1	0	
4:0	0	0	0	0	0	0	0	
5:0	0	0	0	0	0	0	0	
6:0	1	0	0	0	0	0	0	
7:0	0	0	1	0	0	0	0	
*/

class matrix_design_only_col;
  parameter int N = 8;
  
  rand bit matrix[N][N];
  
  //constraint to make sure each column has only one 1
  //Note: matrix.sum only operates on 1-d array
  constraint column {foreach(matrix[,j]){
    matrix.sum(row) with (row.sum(col) with (col.index == j ? int'(col):0)) == 1;}}
    
endclass
    
    
module tb;
  matrix_design_only_col m1;
  
  initial begin
    m1=new();
    assert(m1.randomize()) else
      $fatal(0,"randomization::eror");
    
    foreach(m1.matrix[i]) begin
      $write("%d:",i);
      foreach(m1.matrix[,j]) begin
        $write("%d\t",m1.matrix[i][j]);
      end
      $display;
  end
  end
endmodule