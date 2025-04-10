//recursive function to generate factorial of a given number n
module tryfact;
  
   //make sure to declare the function automatic as subroutines under modules default to static
  //static method recursive calls don't deallocate memory until end of simulation resulting in wrong result returned by function
  function automatic int factorial(input int n);
    if(n<=1) begin //as 0! =1 & 1!=1
      return 1;
    end
    else begin //Ex:- 3! = 3 x 2!=> 3 x 2 x 1! => 3x2x1 = 6
      return n * factorial(n-1);
    end
  endfunction
  
  initial begin
    int num = 5;
    int fact_res;
    fact_res = factorial(num);
    $display("factorial of %d is %d",num,fact_res); 
  end
  
endmodule