//Problem:-Write a piece of code to constraint a variable in such a way that the value of the variable must not contain 10,20 and it should not fall in the range of 50 and 65. 
class invert_constraint;
  rand bit [7:0] a;
  
  constraint inv_a {!(a inside {10,20,[50:65]});} //invert the constraint using logical inversion operator !
endclass
                      
module test;
  invert_constraint i1;
  
  initial begin
    i1=new();
    repeat(5) begin
      assert(i1.randomize()) else
        $fatal(0,"invert_constraint::randomization failed");
      $display("value of a:%d",i1.a);
    end
  end
endmodule