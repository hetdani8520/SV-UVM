//Problem:- constraint inheritance
//Constraint in parent overriden by child (allowed as far as child uses the same constraint name & prototype as used by parent)  
  class parent;
  rand bit [7:0] a;
  
  constraint c_a {a inside {[50:60]};}
endclass

class child extends parent;
  
  //constraint from parent overriden by child (need to follow same prototype & name when overriding constraint in child defined originally in parent class)
  constraint c_a {a inside {[20:30]};}
  
  function new;
    super.new();
  endfunction
endclass

module test;
  parent p1;
  child c1;

  initial begin
      p1=new();
  	  c1=new();
  repeat(5) begin
    assert(p1.randomize()) else
      $fatal(0,"p1::randomization failed");
    $display("value of a from parent class using parent constraint=%d",p1.a);
  end
  
    repeat(5) begin
      assert(c1.randomize()) else
        $fatal(0,"c1::randomization failed");
      $display("value of a from child class using overriden constraint from parent=%d",c1.a);
  end
  end
  
endmodule