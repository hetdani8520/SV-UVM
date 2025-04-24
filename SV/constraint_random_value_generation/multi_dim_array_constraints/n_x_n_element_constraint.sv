//implement a n*n matrix ensure value 2 appears exactly 3 times and remaining elements are unique.

class n_x_n_element_constraint;
  parameter int n = 3;
  rand bit [3:0] arr[n][n];
  
  //constraint to make sure 2 appears only 3 times in the entire array
  constraint arr_exactly_three_2 {arr.sum(item) with (item.sum() with (int'(item==2))) == 3;}
  
  //constraint on rest elements in the array being unique
  constraint rest_arr_unique {foreach(arr[i,j]){
    foreach(arr[m,k]){
      //only compare if both the array elements are non-2
      //(i!=m || j!=k)-->This makes sure we are not comparing each element to itself
      //(arr[i][j] != 2 && arr[m][k] != 2)-->this ensures we only care about non-2 elements
      if(arr[i][j] != 2 && arr[m][k] != 2 && (i!=m || j!=k)){
        //So whenever we find two elements that:
        //a)Are not equal to 2, and
        //b)Are at different positions,
		//We force them to have different values.
        arr[i][j] != arr[m][k];}}}}
  
endclass

module tb;
  n_x_n_element_constraint e1;
  
  initial begin
    e1=new();
    repeat(3) begin // 3 iteration
    assert(e1.randomize()) else
      $fatal(0,"randomization error");
    foreach(e1.arr[i]) begin
      $write("%d:",i);
      foreach(e1.arr[,j]) begin
        $write("%d\t",e1.arr[i][j]);
      end
      $display;
    end
      $display("======================================");
    end
  end
endmodule