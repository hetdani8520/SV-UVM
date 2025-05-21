//Write a System Verilog constraint to generate an array of size 20. The array should only include values in the range [0:5]. The value 4 should appear exactly 4 times, 5 should appear exactly 5 times, and 3 should appear at least 3 times. The remaining elements can be any value from the allowed range. Also, no two consecutive elements in the array should be the same.

//x elements same(each with value y) & remaining elements can take any value in range
//4 elem(x=4), 5 elem(x=5), 3 elem(x>=3), rest can take any value within range, range = [0:5]

class misc_7;
  rand bit [3:0] arr[];
  
  constraint size {arr.size() == 20;}
  
  constraint range {foreach(arr[i]){
    arr[i] inside {[0:5]};}}
  
  constraint same {arr.sum() with (int'(item==5)) == 5;
                   arr.sum() with (int'(item==4)) == 4;
                   arr.sum() with (int'(item==3)) >= 3;
                  }
  
  constraint no_consecutive_elem_same {foreach(arr[i]){
    if(i>0){
      arr[i] != arr[i-1];}}}
      
   //remaining elem can take any value between 0:5
endclass
      
module test;
  misc_7 m2;
  
  initial begin
    m2=new();
    assert(m2.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",m2.arr);
  end
endmodule