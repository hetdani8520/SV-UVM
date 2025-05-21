//unique n-d arr constraint

class uniq_n_d_arr;
  parameter int N = 3;
  rand bit [3:0] arr[N][N];
  
  //all elements unique
  constraint all_elem_uniq {foreach(arr[i,j]){
    foreach(arr[k,l]){
      if(i!=k || j!=l){ //no same indices comparison
        arr[i][j] != arr[k][l];}}}}
        
  
  //only "every" row unique
  constraint only_every_row_uniq {foreach(arr[i,j]){
          foreach(arr[i,k]){
            if(j<k){
              arr[i][j] != arr[i][k];}}}}
    
  
  //only "every" col unique
  constraint only_every_col_uniq {foreach(arr[i,j]){
    foreach(arr[k,j]){
      if(i<k){
        arr[i][j] != arr[k][j];}}}}
  
  
 //only "every" main-diagonals unique
 constraint only_every_main_diag_uniq {foreach(arr[i]){
    foreach(arr[k]){
      if(i<k){
        arr[i][i] != arr[k][k];}}}}
  
  
 //only "every" anti-diagonals unique
 constraint only_every_anti_diag_uniq {foreach(arr[i]){
          foreach(arr[k]){
            if(i<k){
              arr[i][N-i-1] != arr[k][N-k-1];}}}}
endclass
        
        
module test;
  uniq_n_d_arr n1;
  
  initial begin
    n1=new();
    
    //all constraints disabled
    n1.constraint_mode(0);
    
    //only "every" anti-diagonal unique
    n1.only_every_anti_diag_uniq.constraint_mode(1);
    
    assert(n1.randomize()) else
      $fatal(0,"randomization error");
    
    //debugg
    foreach(n1.arr[i]) begin
      $write("%d:",i);
      foreach(n1.arr[,j]) begin
        $write("%d\t",n1.arr[i][j]);
      end
      $display;
    end
  end
  
endmodule