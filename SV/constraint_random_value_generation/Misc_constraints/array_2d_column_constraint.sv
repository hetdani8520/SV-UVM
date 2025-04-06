//2d-array column constraint (symmetric) - NxN
//place N (where N is size of the matrix) number of 1s such that maximum number of 1 in each column is 1

class array_2d_column_constraint;
  
  parameter int N = 5;
  rand bit arr[N][N];
  
  //1st method
  //Internally:
  //1)arr.sum iterates over 1-dimension of array i.e. arr[0]+arr[1]...arr[7]
  //2)each iteration on 1 will have 8 columns (in this case as it is 8x8)
  //3)mem.sum() with (int'(mem[item.index][0])) == 1 ;
  //arr.sum() with (int'(arr[item.index][1])) == 1 ;
		//...
  //arr.sum() with (int'(arr[item.index][15])) == 1 ;
//Then expand the sum methods

  //int'(arr[0][0]) + int'(arr[1][0] + ....arr[7][0]) ==1;
  //int'(arr[0][1]) + int'(arr[1][1] + ....arr[7][1]) ==1;
	//....
  //int'(arr[0][7]) + int'(arr[1][7] + ....arr[7][7]) ==1;
  
  //only one 1s in each column
  constraint column {foreach(arr[,j]) arr.sum with (int'(arr[item.index][j])) == 1;}
  
  //2nd method
  /*
   constraint c1 {
     foreach(arr[i,j]) {
      //a[i].sum(row) with (int'(row)) == 15; // rows
       arr.sum(row) with (row.sum(col) with (col.index == j  ? int'(col) : 0))== 1; // cols
     }}
  */
  
endclass

module tb;
  array_2d_column_constraint c1;
  
  initial begin
    c1=new();
    assert(c1.randomize()) else
      $fatal(0,"Randomization error");
    
    foreach(c1.arr[i]) begin
      $write("%d:",i);
      foreach(c1.arr[,j]) begin
        $write("%d\t",c1.arr[i][j]);
      end
      $display;
    end
    
  end
endmodule