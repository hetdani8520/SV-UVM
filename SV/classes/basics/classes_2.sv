//Problem:-Write a snippet constituting a class having two data members, take multiple objects assign different values to the different objects and delete one of the objects before finish.

class classes_2;
  bit [2:0] a;
  bit [2:0] b;
  
  function void display();
    $display("value of a=%d & b=%d",a,b);
  endfunction
endclass

module test;
  classes_2 h1_obj, h2_obj;
  
  initial begin
    h1_obj=new();
    h2_obj=new();
    h1_obj.a=2;
    h1_obj.b=4;
    h2_obj.a=1;
    h2_obj.b=3;
    h1_obj.display();
    h2_obj.display();
    //h2_obj=null; //this does not necessarily deallocate memory for the oj pointed by handle h2_obj
    h2_obj=new(); //this DOES deallocate memory for the object previously pointed by handle h2_obj (new object gets created & allocate memory pointed by handle h2_obj)
    h2_obj.display();
    
  end
endmodule
