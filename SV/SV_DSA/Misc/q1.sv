module tb;
  
  function int first_non_zero_idx(input int a);
    int count = 0;
    for(int i = 0;i<$bits(a);i++) begin
      if(a[i] != 0) begin
        count++;
      end
      if(count == 1) begin
        return i;
      end
    end
  endfunction
  
  initial begin
    int idx = 0;
    idx = first_non_zero_idx(32'd200);
    $display("first non-zero index=%d",idx);
  end
  
  
  
endmodule