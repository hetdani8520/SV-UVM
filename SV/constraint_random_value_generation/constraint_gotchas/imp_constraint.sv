//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LRM:- expression -> constraint_set
//The expression can be any integral or real expression. The constraint_set represents any valid constraint or
//an unnamed constraint set.
//"The Boolean equivalent of the implication operator a -> b is (!a || b). This states that if the expression
//is true, then all of the constraints in the constraint set shall also be satisfied. Otherwise, the random values
//generated are unconstrained. Conversely, if the constraints in the constraint set are not satisfied, then the
//expression shall be false."
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class imp_constraint;
  rand bit [4:0] b;
  bit a = 1'b1;
  
  constraint imp { a==1 -> {b inside {[5:10]};}}
endclass

module test;
  imp_constraint i1;
  
  initial begin
    i1=new();
    
    //Case-1:- (a==1 -> b within 5:10 (both inclusive))
    repeat(5) begin
    assert(i1.randomize()) else
      $fatal(0,"i1::randomization failed");
      $display("value of constrained b:%d",i1.b);
    end
    
    //Case-2:- !a || b (a is false, b should be randomized unconstrained since a is false -vacuity)
    i1.a = 0;
    repeat(5) begin
    assert(i1.randomize()) else
      $fatal(0,"i1::randomization failed");
      $display("value of un-constrained b:%d",i1.b);
    end
  end
endmodule