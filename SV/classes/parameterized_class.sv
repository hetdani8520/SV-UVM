//Parameterized classes also portray Polymorphism
//Ability of the code to act differently for different types (statically at compile time using parameterized types)

//Int stack
class stack #(parameter type T=int);
  local T stack[100]; //hold data values on stack
  local T top;
  
  function void push(input T data); //push new value on top
    stack[++top] = data;
  endfunction
  
  function T pop();              //pop value from top
    return stack[top--];
  endfunction

endclass

module test;
  stack #(int) s1;
  
  initial begin
  s1=new();
  
  for(int i=0;i<5;i++)  //push values on stack
    s1.push(i*2);
  
    for(int i=0;i<5;i++) //pop values on stack from the top
    $display("popped value from stack is:%d",s1.pop());
  end
  
endmodule