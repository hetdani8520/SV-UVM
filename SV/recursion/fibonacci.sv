//fibonacci sequence for first "n" numbers
//BEWARE:indexing starts from 0
module fibonacci;
  
  function automatic int fib(input int n);
    if(n == 0) begin
      return 0;
    end
    if(n == 1) begin
      return 1;
    end
    if(n > 1) begin
      return fib(n-1) + fib(n-2);
    end
  endfunction
  
  initial begin
    int num=10;
    int arr[]; //dyn_arr only declared (not initialized -initializing happens below using appending operation)
    for(int i=0;i<num;i++) begin
      arr= {arr,fib(i)};
    end
    $display("fibonacci sequence for first %d numbers are %p",num,arr);
    
  end
  
endmodule
