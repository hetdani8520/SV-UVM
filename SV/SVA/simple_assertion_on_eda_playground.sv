module simple_assertion;
  bit a, b;
  logic clk;
  
  a1:assert property(@(posedge clk)
                     a |=> b) 
    $display("assertion passed at %t",$time); 
    else
    $warning(0,"assertion failed");
    
  
  //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
  end
    
  initial begin
    clk=0;
    forever begin
      #5 clk = ~ clk;
    end
  end
    
  initial begin
    a=0;
    b=0;
    @(posedge clk); //5
    a=1;
    @(posedge clk); //15
    b=1;
    @(posedge clk); //25 (passed)
    a=1;
    @(posedge clk); //35 (passed)
    b=0;
    @(posedge clk); //failed from 45 onwards every other/alternate cycle
    repeat(5) @(posedge clk);
    
    $finish;
  end
endmodule