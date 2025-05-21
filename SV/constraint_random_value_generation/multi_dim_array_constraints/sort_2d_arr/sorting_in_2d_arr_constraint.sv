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
    foreach(arr[k]){
      if(i<k){
        arr[i][i] < arr[k][k];}}}}
  
  //only anti-diag sort
  constraint only_anti_diag {foreach(arr[i]){
    foreach(arr[k]){
      if(i<k){
        arr[i][N-1-i] < arr[k][N-1-k];}}}}

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