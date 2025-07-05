//the input arrays are assumed to be sorted already
//the resultant merged sorted array is represented by merge_sort arr below
module merge_sort;
  bit [5:0] arr1[] = '{3,4,5,7,8,9};
  bit [5:0] arr2[] = '{1,2,4,6,7,8,9};
  
  bit [5:0] merge_sort[];
  
  int i,j,k;
  
  initial begin
    merge_sort = new[arr1.size() + arr2.size()];
    
    while(i<arr1.size() && j<arr2.size()) begin
      if(arr1[i] < arr2[j]) begin
        merge_sort[k] = arr1[i];
        k++;
        i++;
      end
      else begin
        merge_sort[k] = arr2[j];
        k++;
        j++;
      end
    end
    
    while(i<arr1.size()) begin
      merge_sort[k] = arr1[i];
      k++;
      i++;
    end
    
    while(j<arr2.size()) begin
      merge_sort[k] = arr2[j];
      k++;
      j++;
    end
    
    $display("merged sort arr=%p",merge_sort);
  end
endmodule