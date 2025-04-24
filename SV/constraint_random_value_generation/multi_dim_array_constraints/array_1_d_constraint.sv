//Write a System Verilog constraint to generate an array of size 20. The array should only include values in the range [0:5]. The value 4 should appear exactly 4 times, 5 should appear exactly 5 times, and 3 should appear at least 3 times. The remaining elements can be any value from the allowed range. Also, no two consecutive elements in the array should be the same.

class arr_1d_constraint;
  rand bit [3:0] arr[];
  
  //size of array=20
  constraint size {arr.size() == 20;}
  
  //elements should be within 0:5
  constraint element_range {foreach(arr[i]){
    arr[i] inside {[0:5]};}}
  
    constraint certain_elements{
      //value 4 should appear exactly 4 times
      arr.sum() with (int'(item==4)) == 4;
      //3 should appear at least 3 times
      arr.sum() with (int'(item==3)) >= 3;
      //5 should appear exactly 5 times
      arr.sum() with (int'(item==5)) == 5;}
      
      //consecutive elements should be different
      constraint consecutive_elements_diff {foreach(arr[i]){
        if(i>0){
          arr[i] != arr[i-1];}}}
endclass

module test;
  arr_1d_constraint a1;
  
  initial begin
    a1=new();
    assert(a1.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",a1.arr);
  end
endmodule
      