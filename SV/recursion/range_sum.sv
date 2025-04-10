//sum of all non-negative numbers from 0 to n
//n = boundary/terminating condition uptill which the sum should be calculated

module range_sum;
  
  //make sure to declare the function automatic as subroutines under modules default to static
  //static method recursive calls don't deallocate memory until end of simulation resulting in wrong result returned by function
  function automatic int sum(input int n);
    if(n>0) begin
      return n + sum(n-1);
    end
    //not necessary but better to have this than a dangling if statement
    else begin
      return 0;
    end
  endfunction
  
  initial begin
    int sum_of_all_num;
    int n = 10;
    sum_of_all_num = sum(n);
    $display("sum of all numbers uptill %d is %d",n,sum_of_all_num); 
  end
  
endmodule