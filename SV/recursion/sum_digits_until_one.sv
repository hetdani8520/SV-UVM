//sum of all the digits of number n until sum becomes single digit
//remainder of num % 10 gives us a digit in the number
//quotient when num / 10 gives us the part of the number on which recursion should happen next
//recursion should stop if the number is 0 or has become a single digit (in which case the quotient will be 0 when divided by 10)
module add_digits_until_one;
  
  function automatic int sum_digits_until_one(input int num);
    int sum;
    if(num > 0 || num > 9) begin
      sum = num % 10; //this gives you remainder
      num = num /10; //this gives quotient which will be used recursively
             //remainder  //quotient
      return sum + sum_digits_until_one(num);
    end
    //if quotient is 0 then recursion should terminate because that would also mean the number is already single digit now
    if(num == 0) begin//base case for when recursion should end
      return 0;
    end
  endfunction
  
  initial begin
    int n = 5;
    int res = sum_digits_until_one(n);
    $display("sum of digits of %d is %d",n,res);
  end
endmodule