//Pass by ref in task/function:- changes made to the formal argument pass by ref to the function/task will immediately affect the signal outside the function
//Sv adds pass by reference provision only in automatic tasks/functions.
module pass_by_ref;
  int s;
  int a,b; //here a & b are passed by reference
  function int sum(ref int a,b);
    a = a + b;
    return a + b;
  endfunction
  
  initial begin
    a=10;
    b=10;
    s = sum(a,b); //pass value by ref (initialize values to be passed to func by ref)
    $display("pass by ref values:a=%d, b=%d",a,b);
    $display("sum of a & b = %d",s);
  end
endmodule