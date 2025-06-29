module max_elem_of_arr;
  bit [4:0] arr[] = '{4,3,2,1,0,6,5,10};
  
  bit [4:0] max_val = 0;
  bit [4:0] max_idx = 0;
  
  initial begin
    for(int i=0;i<arr.size();i++) begin
      if(arr[i] > max_val) begin
        max_val = arr[i];
        max_idx = i;
      end
    end
    $display("max_val=%d",max_val);
    $display("max_idx=%d",max_idx);
  end
  
endmodule