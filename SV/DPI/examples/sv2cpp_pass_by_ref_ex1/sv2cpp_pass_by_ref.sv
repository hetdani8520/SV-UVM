module sv2cpp_pass_by_ref;
  bit [3:0] arr_to_pass[5];
  export "DPI-C" function sv_unique;
  import "DPI-C" context function void cpp_pass_by_ref(bit [3:0] arr2[5]);
  
  initial begin
    arr_to_pass = '{1,1,2,2,4};
    cpp_pass_by_ref(arr_to_pass);
  end
  
  function int sv_unique(bit [3:0] arr[5]);
    int cnt;
    for(int i=0;i<$size(arr);i++) begin
      cnt=0;
      for(int j=0;j<$size(arr);j++) begin
        if(arr[i] == arr[j]) begin
          cnt++;
        end
      end
      if(cnt == 1) begin //unique
        return arr[i];
      end
    end
  endfunction
endmodule
