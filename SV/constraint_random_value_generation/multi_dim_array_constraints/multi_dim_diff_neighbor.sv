//Problem:- Write a constraint for 2D Array where value of an element should be different from its neighbor (neighbors don't include diagonal neighboring element here)
//Credits:- https://verificationacademy.com/forums/t/constraint-question-write-a-constraint-for-2d-array-where-value-of-an-element-should-be-different-from-its-neighbor/45757

class multi_dim_diff_neighbor;
  parameter int N = 4;
  rand bit [3:0] arr[N][N];
  //Ex: (0,0) != (1,0) //same col, diff row
  //    (0,0) != (0,1)	//same row, diff column
  constraint diff_neighbor_cons {foreach(arr[i,j]){
    i < ($size(arr,1) - 1) -> arr[i+1][j] != arr[i][j]; //same column, diff row
    j < ($size(arr,2) - 1) -> arr[i][j] != arr[i][j+1]; //same row, diff column
  }}
  
endclass
    
module tb;
  multi_dim_diff_neighbor m1;
  initial begin
    m1 = new();
    assert(m1.randomize()) else
      $fatal(0,"randomization::error");
    foreach(m1.arr[i]) begin
      $write("%d:",i);
      foreach(m1.arr[,j]) begin
        $write("%d\t",m1.arr[i][j]);
      end
      $display;
    end
  end
endmodule