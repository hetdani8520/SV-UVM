//all variables & subroutines(tasks/functions with asso local args/vars) are defaulted to static inside modules
module static_var_scope_and_lifetime_module;

  //scope of this counter falls under the module scope
  //lifetime of this variable ends once variable is out of scope which in this case will be outside the module
  int counter = 1;
  
  initial 
  
  begin:A
    //scope of this counter variable is under begin..end with label A
    //lifetime ends once the variable is out of scope
    static int counter = 0;
    repeat(5) begin
      $display("counter value inside begin..end scope=%d", counter++); //0 1 2 3 4
  end
  end
  
  initial begin:B
    //module scope counter variable incremented
    counter = counter + 1'b1;
    //counter declared & initialized in module scope printed here
    //a static variable can be referred to by its hierarchical name as shown below
    $display("counter value in module scope=%d",static_scope_and_lifetime_module.counter); //2
      //$display("counter value in module scope=%d",counter); //2
  end
  
endmodule