//LRM:- "Tasks/functions defined within a module, interface, program, or package default to being static, with all declared items
//being statically allocated. These items shall be shared across all uses of the task executing concurrently"

//Method (task/func) inside module default to static
//WIP:-Need to explore variables, loop iterator scope under modules and classes

module factorial;
  int ans;
  function automatic int fact(input int n); //statis by default unless explicitly defined automatic
    if(n>=2) //0!=1 & 1!=1
      return (n * fact(n-1));
      else
        return 1;
  endfunction
  
  initial begin
    for(int i=0;i<=3;i++) begin //list factorial of all the numbers uptill & including 3!
      ans = fact(i);
      $display("factorial of %d  is:%d",i,ans);
  end
    
  end
endmodule