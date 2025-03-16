//Problem:-Write a snippet to track the number of times class object has been created.
//Note:-static properties of class can be accessed by null handles, class name(using scope resolution operator) as well as by valid handles pointing to resp objects

class static_usage1;
  int id;
  static int count=0;
  
  function new();
    id=count++; //static variables of class are shared across all instances of the class
  endfunction
endclass

module test;
  static_usage1 h1,h2,h3,h4;
  initial begin
    h1=new(); //id=0, count=1  
    h2=new(); //id=1, count=2
    h3=new(); //id=2, count=3
    $display("count of objects created=%d",static_usage1::count); //static variables of class can be accessed by class name (using scope resolution operator)
    $display("static variable value (access using null handle)=%d",h4.count);
    $display("static variable value (access using valid handle pointing to object)=%d",h3.count);
  end
endmodule

