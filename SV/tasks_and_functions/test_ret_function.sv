//Systemverilog introduces C-like return statement (retains the ability to assign the return value from the function to function's name).
//Provides ability to exit function besides just reaching end function
module test;
  int value;
  function int test_ret(input int n);
    if(n==0) return 2; //abort the function if n=0
    else if(n>=1 && n<5)
      $display("n=%d",n);
    else
      $display("n is greater than of equal to 5");
  endfunction
  
  initial begin
    #5;
    value = test_ret(0);
    if(value == 2) begin
      $display("return value of function=%d",value);
    end
  end
endmodule