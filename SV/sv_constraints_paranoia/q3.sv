class q3;
  parameter int X = 3;
  parameter int Y = 3;
  parameter int Z = 3;
  rand bit [5:0] arr[X][Y][Z];
  
  //this constraint sometimes becomes to complex for solver to handle
  //TODO:need to come up with alternative logic (without using unique keyword)
  constraint uniq {foreach(arr[i,j,k]){
    foreach(arr[l,m,n]){
      if((i!=l) || (j!=m) || (k!=n)){
        arr[i][j][k] != arr[l][m][n];}}}}

  //constraint uniq {unique{arr};}
endclass
        
module test;
  q3 q3_h;
  
  initial begin
    q3_h = new();
    assert(q3_h.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",q3_h.arr);
  end
endmodule