//segregate zeros using single wr_ptr (this method preserves the order of non-zero vals post segregation)
//Note:one can use two-ppointer technique as well but original arr non-zero vals order will not be preserved post segregation
module segregate_zeros;
  bit [5:0] arr[] = {6,7,0,3,0,0,2,1,1,0,9,10,11,12};
  
  bit [5:0] wr_ptr = 0;
  
  initial begin
    for(int i=0;i<arr.size();i++) begin
      if(arr[i] != 0) begin
        arr[wr_ptr] = arr[i];
        wr_ptr++; //only increment if elem is non-zero
      end
    end
    
    for(int j=wr_ptr;j<arr.size();j++) begin
      arr[j] = 0;
    end
    
    $display("final arr with segregated vals (preserved order of non-zero vals) = %p",arr);
  end
endmodule