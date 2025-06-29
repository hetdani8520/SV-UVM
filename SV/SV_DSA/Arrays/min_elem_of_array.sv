module min_elem_of_arr;
  bit [4:0] arr[] = '{4,3,2,1,0,6,5,10};
  
  bit [4:0] min_val = 31;
  bit [4:0] min_idx = 31;
  
  initial begin
    for(int i=0;i<arr.size();i++) begin
      if(arr[i] < min_val) begin
        min_val = arr[i];
        min_idx = i;
      end
    end
    $display("min_val=%d",min_val);
    $display("min_idx=%d",min_idx);
  end
  
endmodule