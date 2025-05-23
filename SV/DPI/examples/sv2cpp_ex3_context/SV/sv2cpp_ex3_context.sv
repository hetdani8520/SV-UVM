//context function example

module sv2cpp_context;
  
   //export function prototype in SV world does not require any prototype of function
  export "DPI-C" function fact_sv; 
  import "DPI-C" context function int fact_cpp(int a);
  
  function automatic int fact_sv(int in);
    //$display("in=%d",in);
    if(in<=1) begin
      return 1;
    end
    else begin
      return (in * fact_sv(in-1));
    end
  endfunction
  
  
  initial begin
    int factorial, num;
    num = 5;
    
    $display("inside SV world");
    factorial = fact_cpp(num);
    $display("factorial(from cpp world) of %d is %d",num, factorial);
  end
  
endmodule