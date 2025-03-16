//Problem:- Write a class with two objects of same class and perform the object assignment of one class object handle to another handle.
//1)Update the property using both handles and observe the changes accordingly.
//2)Deallocate the assigned object.

//Note:Handles are not obbjects. They are pointer to objects

class obj_assign;
  bit [3:0] a;
  
  function void disp();
    $display("value of a=%d",a);
  endfunction
endclass

module test;
  obj_assign h1_obj,h2;
    
    initial begin
      h1_obj=new();
      h1_obj.a=9;
      h1_obj.disp(); //a=9
      h2=h1_obj; //h2 handle points to the same object as h1_obj handle points to
      h2.a=12;
      h2.disp(); //a=12
      
      //new() invoked by the same handle allocates second obj & frees the first (garbage collection)
      //But does invoking "null" also deallocate memory?
      h1_obj=new; //allocate second & free/deallocate the first
      
      h1_obj.a=2;
      h1_obj.disp(); //a=2 (allocated new memory for object pointed to by handle h1_obj
      h2.disp(); //h2 still points to the first obj & thus a=12
    end
endmodule