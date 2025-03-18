//Pass by value:- when a task/function is called, the values provided the caller are copied into the input args to the function/task where they becomes local values.
//Upon return, outputs are copied back to the caller.
module pass_by_value;
  int s;
  int a,b;
  function int sum(input int a,b);
    a = a + b;
    return a + b;
  endfunction
  
  initial begin
    a=10;
    b=10;
    s = sum(a,b); //pass value by value (value passed in copied to input args to function/task where they become local values). Upon return, return value/outputs are copied back to caller
    $display("pass by ref values:a=%d, b=%d",a,b);
    $display("sum of a & b = %d",s);
  end
endmodule