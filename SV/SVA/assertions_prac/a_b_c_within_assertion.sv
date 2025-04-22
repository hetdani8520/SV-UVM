//If A happens, C must rise in 5-10 cycles, with B not changing value until then.
module a_b_c_within_assertion;
  bit clk, b, c;
  bit a;
  
  a1:assert property(@(posedge clk)
                     $rose(a) |-> ($stable(b))[*4:9] ##1 $rose(c)) $display("assertion passed at %tns",$time); else
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
    //The below run trace results in assertion to first pass at 45ns (5cycles after b is stable c is true thereafter)
  initial begin
    a=1;
    b=0;c=0;
    repeat(4) @(posedge clk);
    c=1;
    repeat(2) @(posedge clk);
    a=0; b=0; c=0;
    
    $finish;
  end
endmodule