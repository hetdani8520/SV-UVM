//Soft constraint
//all soft constraints associated with a particular variable can be disabled using "disable" keyword as shown below
class soft_constraint;
  rand bit [5:0] a;
  
  constraint sft_a {soft a > 10;
                    a < 20;}
  //constraint dis_sft_a {disable soft a;} //this disables all soft constraints associated with a
endclass

module test;
  soft_constraint s1;
  
  initial begin
    s1=new();
    
    repeat(5) begin
      assert(s1.randomize() with {a inside {[1:9]};}) else //here the inline constraint will be applied by RNG
        $fatal(0,"s1::randomization failed");
      $display("value of a:%d",s1.a);
  end
    
    //disable soft constraint so value of a will be generated unconstrained by solver (assuming soft constraint on a is disabled as shown above)
    repeat(5) begin
      assert(s1.randomize()) else
        $fatal(0,"s1::randomization failed");
      $display("value of a:%d",s1.a);
  end
    
  end
endmodule