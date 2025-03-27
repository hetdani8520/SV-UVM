//Find Max element in a fixed size array (w/o using array.max())
module max_elem_in_array;
  bit [4:0] fixed_arr[7];
  
  //temp variable to hold the intermmediate max value during iterating over an array
  bit [4:0] max_value = 0; //set the default value to 0
  bit [4:0] index;
  
  initial begin
  fixed_arr = '{4,3,5,6,7,8,9};
  foreach(fixed_arr[i]) begin
    if(fixed_arr[i] > max_value) begin
      max_value = fixed_arr[i];
      index = i;
    end
  end
    
    $display("max element from dyn_array is %d residing at index %d",max_value,index);
  end
endmodule