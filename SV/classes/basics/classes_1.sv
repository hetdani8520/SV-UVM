//Problem:-Write a snippet constituting a class with three data members of integral type, and take a subroutine to display the value of the properties
class classes_1;
  
  int a, b, c; //properties of class
  
  //method of class
  function void display();
    $display("value of a=%d,b=%d,c=%d",a,b,c);
  endfunction
  
endclass

module test;
  classes_1 c1_h;
  
  initial begin
    c1_h=new();
    c1_h.a=10;
    c1_h.b=20;
    c1_h.c=30;
    c1_h.display();
  end
endmodule