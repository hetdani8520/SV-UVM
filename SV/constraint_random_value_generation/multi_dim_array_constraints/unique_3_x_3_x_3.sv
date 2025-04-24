//Write a constraint to randomize 3x3x3 array with unique elements without using unique construct.
class unique_3_x_3_x_3;
  rand bit [5:0] arr[3][3][3];
  
  //constraint to make sure every element of arr[i,j,k] is different from everyy element in arr[m,n,o]. This is checked for all distinct indices.
  constraint unique_c {foreach(arr[i,j,k]){
    foreach(arr[m,n,o]){
      if(i!=m || j!=n || k!=o){
        arr[i][j][k] != arr[m][n][o];}}}}
  
  //the element range should be sufficient enough to accomodate the uniqueueness
  constraint c2 {foreach(arr[i,j,k]){
          arr[i][j][k] inside {[0:50]};}}
endclass
        
module test;
  unique_3_x_3_x_3 u1;
  
  initial begin
    u1=new();
    assert(u1.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",u1.arr);
  end
endmodule