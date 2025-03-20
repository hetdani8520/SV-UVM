//This code removes duplicate elements from dyn arr & shrinks the array post-removal of duplicate elements
//Note: In the process above, the dyn_arr does not preserve its original element order. (TODO:maybe a future enhancement)
module duplicate_elem_in_array;
  bit [3:0] dyn_arr[] = '{1,2,3,4,5,4,6,6,7,8,8,8};
  bit [3:0] asso[int];
  
  initial begin
    //shuffled initialized dyn_arr for variability
    dyn_arr.shuffle();
    $display("shuffled dyn_array with duplicates=%p",dyn_arr);
    
    //This logic keeps track of duplicate elements in a temp asso array
    //the "key" to asso array represents elements of dyn_arr while the corresponding "value" to asso array represents number of times a element has been repeated in dyn_array
    foreach(dyn_arr[i]) begin
      asso[dyn_arr[i]]++;
    end
    $display("asso array=%p",asso);
    
    dyn_arr.delete();
    
    //This shrinks & update the dyn_arr to remove duplicate elements
    foreach(asso[j]) begin
      dyn_arr={dyn_arr,j};
    end
    $display("removed duplicates from dyn_array=%p",dyn_arr);
  end
endmodule