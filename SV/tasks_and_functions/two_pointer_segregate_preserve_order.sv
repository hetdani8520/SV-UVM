//segregate array while preserving the original order
//arr='{1, 9, 8, 4, 0, 0, 2, 7, 0, 6, 0}
//output={1, 9, 8, 4, 2, 7, 6, 0, 0, 0, 0}

module segregate_arr_with_order_preserved;
  bit [3:0] arr[];
  
  function automatic void segregate_arr_po(ref bit [3:0] arr[]);
    bit [3:0] wr_ptr = 0;
    
    foreach(arr[i]) begin
      if(arr[i] != 0) begin
        arr[wr_ptr] = arr[i];
        wr_ptr++; //this increments every-time array is updated & when pre-condition is true (arr[i]!=0)
      end
    end
    
    //This sprinkles zeros based on wr_ptr value after segregating all non-zeros to the right
    for(int j=wr_ptr; j<$size(arr);j++) begin
      arr[j] = 0;
    end
  endfunction
  
  initial begin
    arr = '{1, 9, 8, 4, 0, 0, 2, 7, 0, 6, 0};
    segregate_arr_po(arr);
    $display("arr=%p",arr);
  end
endmodule

