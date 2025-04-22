//If vector A has at least 5 1s, then a B comes, we need to see 7 Cs in a row within 12 cycles.
module a_b_c_assertion;
  bit clk, b, c;
  bit [5:0] a;
  
  a1:assert property(@(posedge clk)
                     $countones(a) >=5 ##1 b |-> ##[1:12] c[*7]) $display("assertion passed at %tns",$time); else
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
  
  initial begin
    a=6'b101111;
    b=0;c=0;
    @(posedge clk);
    b=1;
    c=1;
    repeat(9) @(posedge clk);
    a=0; b=0; c=0;
    
    $finish;
  end
endmodule