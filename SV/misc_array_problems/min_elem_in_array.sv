//Find minimun value in the array (w/o using array.min() method)
module min_elem_in_array;
  bit [4:0] fixed_arr[7];
  
  //make sure to set the feault value of temp variable to be any random max value which will be ideally unreachable for the array element scope
  bit [4:0] min_value = 1000;
  bit [4:0] index;
  
  initial begin
  fixed_arr = '{4,3,5,6,7,8,9};
  foreach(fixed_arr[i]) begin
    if(fixed_arr[i] < min_value) begin
      min_value = fixed_arr[i];
      index = i;
    end
  end
    
    $display("min element from dyn_array is %d residing at index %d",min_value,index);
  end
endmodule