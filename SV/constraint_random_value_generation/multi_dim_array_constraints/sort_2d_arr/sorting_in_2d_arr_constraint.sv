//sorting of a multi-dim array

class sort_2d;
  parameter int N = 3;
  rand bit [3:0] arr[N][N];
  
  //only rows sort
  constraint only_row_sort {foreach(arr[i,j]){
    foreach(arr[i,k]){
      if(j<k){ //this skips all self-comparisons & all repeats as well
        arr[i][j] < arr[i][k];}}}}
  

  //only cols sort
  constraint only_col_sort {foreach(arr[i,j]){
          foreach(arr[k,j]){
            if(i<k){
              arr[i][j] < arr[k][j];}}}}
  
  //only main diag sort
  constraint only_main_diag {foreach(arr[i]){
      if(i<N-1){ //a<b & b<c then a<c (transitivity of the less-than relation) --> [(0,0) < (1,1), (1,1) < (2,2) => (0,0) < (2,2)]
        arr[i][i] < arr[i+1][i+1];}}}
  
  //only anti-diag sort
  constraint only_anti_diag {foreach(arr[i]){
    if(i<N-1){ //a<b & b<c => a<c (transitivity of the less-than relation) --> [(0,2) < (1,1), (1,1) < (2,0) => (0,2) < (2,0)]
        arr[i][N-1-i] < arr[i+1][N-i-2];}}}

endclass
      
module test;
  sort_2d s1;
  
  initial begin
    s1=new();
    //disable all constraints
    s1.constraint_mode(0);
    
    //only turn on rows sort constraint
    s1.only_row_sort.constraint_mode(1);
    
    assert(s1.randomize()) else
      $fatal(0,"randomization error");
    
    //debug
    foreach(s1.arr[i]) begin
      $write("%d:",i);
      foreach(s1.arr[,j]) begin
        $write("%d\t",s1.arr[i][j]);
      end
      $display;
    end
  end
endmodule