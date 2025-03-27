//Sorting the given array in ascending order (w/o using built-in array.sort())
module sort_fix_array;
  
  bit [4:0] arr1[7];
  
  //temp variable
  bit [4:0] temp;
  
  initial begin
    arr1 = '{3,3,4,5,1,2,7};
    for(int i=0;i<$size(arr1);i++)begin
      for(int j=i+1;j<$size(arr1);j++)begin
        if(arr1[i] > arr1[j]) begin
          //keep in mind this swapping is valuable to get the smaller value into arr1[i]. The swapped value in arr1[j] will be used by arr[i] in next iteration for comparison.
          temp = arr1[i]; 
          arr1[i] = arr1[j];
          arr1[j] = temp;
        end
      end
    end
    $displayh("sorted array=%p",arr1);
  end
  
endmodule