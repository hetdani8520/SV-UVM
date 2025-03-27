//Merge two sorted arrays resulting in a sorted array(w/o using concat & sort operations/functions in SV)
//Algorithm copied from here:- https://www.geeksforgeeks.org/merge-two-sorted-arrays/#expected-approach-using-merge-of-merge-sort-on1-n2time-and-on1-n2-space

module merge_sort_fix_array;
  
  bit [4:0] arr1[5];
  bit [4:0] arr2[7];
  
  bit [4:0] arr3[];
  
  bit [4:0] i,j,k = 0;
  
  initial begin
    arr1 = '{1,2,3,4,5};
    arr2 = '{7,8,9,10,11,12,13};
    //$display("array1=%p",arr1);
    //$display("array2=%p",arr2);
    arr3 = new[$size(arr1) + $size(arr2)];
    
    while(i < $size(arr1) && j < $size(arr2)) begin
      if(arr1[i] < arr2[j]) begin
        arr3[k] = arr1[i];
        k++;
        i++;
      end
      else begin
        arr3[k] = arr2[j];
        k++;
        j++;
      end
    end
    
   while(i < $size(arr1)) begin
     arr3[k] = arr1[i];
        i++;
        k++;
   end
    
    while(j < $size(arr2)) begin
      arr3[k] = arr2[j];
        j++;
        k++;
   end
  
    $display("merge sorted arrays=%p",arr3);
  
  end
  
endmodule