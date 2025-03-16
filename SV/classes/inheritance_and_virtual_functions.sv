//All credits to edaplayground for problem statement:- https://www.youtube.com/watch?v=HtSabe2xlB8&list=PLScWdLzHpkAcNa1vjkzPY7L1YiLbH0p44&index=5
//Polymorphism:- ability of the code to act differently for different types
class class_a;
  virtual function void print();
    $display("class_a");
  endfunction : print
endclass : class_a

class class_b extends class_a;
  virtual function void print(); 
    $display("class_b");
  endfunction : print
endclass : class_b

module top;
  initial begin
    
    // 1) what gets displayed for each print(), explain why
    $display("1");
    begin
      class_a a;
      class_b b;

      a = new;
      b = new;
      a.print(); //class_a
      b.print(); //class_b
    end
    
    // 2) what gets displayed for each print(), explain why
    $display("2");
    begin
      class_a a;
      class_b b;

      b = new;
      a = b;
      a.print(); //class_b (if virtual, then method called based on object pointed to by the handle)
      b.print(); //class_b
    end
    
    // 3) what gets displayed for each print(), explain why
    $display("3");
    begin
      class_a a;
      class_a a2;
      class_b b;
      class_b b2;
      
      b = new;
      a = b;
      a2 = a;
      $cast(b2, a); //b2 = a //downcasting
      a2.print(); //class_b
      b2.print(); //class_b
    end 

  end
endmodule 

// 4) If we remove virtual from the extended class, how does that change things?
//once virtual, always virtual (same output as above)
// 5) If we remove virtual from both classes, how does that change things?
//assignment happens based on handle type & not based on object pointed to by the handle
//Output:
/*
1)class_a
2)class_b

3)class_a
4)class_b

5)class_a
6)class_b
*/