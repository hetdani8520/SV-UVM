//Constraints can be declared external
class external_constraint;
  rand bit [3:0] a;
  
  constraint c_ext_a;
endclass

//constrained declared inside class will be defined outside the class (external constraint)
constraint external_constraint::c_ext_a {a > 10;}

module test;
  external_constraint ex1;
  
  initial begin
    ex1=new();
    repeat(5) begin
    assert(ex1.randomize()) else
      $fatal(0,"ex1::randomization failed");
      $display("value of a:%d",ex1.a);
    end
  end
endmodule