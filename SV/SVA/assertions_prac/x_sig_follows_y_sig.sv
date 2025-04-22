//There are 2 signals x_sig and y_sig. On next clock of x_sig we should get y_sig.
//Write an assertion for the same. The assertion should be disabled when rst_n is high.
//Credits for problem statement:- https://reverent-northcutt-8163cd.netlify.app/blog/common_assertion/
module x_sig_follows_y_sig;
  bit clk, x_sig, y_sig;
  bit rst;
  
  a1:assert property(@(posedge clk) disable iff (rst)
                     (x_sig |-> ##1 y_sig)) $display("assertion passed at %tns",$time); else
    $warning("assertion failed");
  
  //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
  end
    
  initial begin
    clk=0;
    forever begin
      #5 clk = ~clk;
    end
  end
    //FYI: with overlapping implication (the consequent evaluation starts in the same cycle of when antecedent is found true)
  initial begin
    //rst = 1; //reset enabled (uncomment this to see if assertion is disabled)
    rst = 0;
    x_sig=1;
    y_sig=0;
    @(posedge clk); //5
    y_sig=1;
    repeat(2) @(posedge clk); //15(2nd) //25(3rd)  (assertion passed at both 15ns & 20ns)
    x_sig=0; y_sig=0;
    @(posedge clk); //0
    
    $finish;
  end
endmodule