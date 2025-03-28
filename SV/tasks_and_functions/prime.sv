//This program returns prime numbers from 0 to n-1
module prime;
  //rand int n;
  
  //prime number def:-A prime number is a whole number greater than 1 that has only two factors: 1 and itself.
  function int prime(int n);
    if(n <= 1) begin
      return 0;
    end
    
    //if number divisible by every other number then it is not prime
    //this loop will break/terminate if input is a prime number
    for(int i=2;i<n;i++) begin
      if(n%i == 0) begin
        return 0;
      end
    end
    return n;
  endfunction
  
  initial begin
    int result;
    //prime numbers from 0 to 10 (if not prime result will be 0 else result= number)
    for(int i=0; i<10;i++) begin
      result = prime(i);
      $display("number %d is prime number:%d",i,result);
    end
  end
  
  
endmodule