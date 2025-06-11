class q4;
  parameter int M = 3;
  parameter int N = 2;
  parameter int MAX_SUM = M*N;
  rand bit [4:0] arr[M][N];
  
  //each value in arr should be either 0 or 1 
  constraint value {foreach(arr[i]){
    foreach(arr[,j]){
      arr[i][j] inside {0,1};}}}
  
  //sum of elements less than MAX_SUM    
      constraint sum_all {arr.sum(row) with (row.sum(col) with (int'(col))) < MAX_SUM;}
endclass
      
module test;
  q4 q4_h;
  
  initial begin
    q4_h = new();
    assert(q4_h.randomize()) else
      $fatal(0,"randomization error");
    
    //debug
    foreach(q4_h.arr[i]) begin
      $write("%d:",i);
      foreach(q4_h.arr[,j]) begin
        $write("%d\t", q4_h.arr[i][j]);
      end
      $display;
    end
  end
endmodule