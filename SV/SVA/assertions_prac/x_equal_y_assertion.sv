//Write an assertion or property to check if signal y is reflected upon signal x immediately
module x_equal_y_assertion;
  bit x, y;
  bit clk;
  
  a1:assert property(@(posedge clk) 
                     $changed(y) |-> y == x) $display("assertion passed at %tns",$time); else
    $warning("assertion failed at %tns",$time);
    
    
  initial begin
    clk=0;
    forever begin
      #5 clk = ~clk;
    end
  end
    
    //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
  end
    
    initial begin
      x=0;
      y=0;
      repeat(5) @(posedge clk);
      x=1;
      y=1;
      @(posedge clk); //passed at 55ns (y changed which caused x to change as well)
      repeat(1) @(posedge clk);
      x=0;
      y=1;
      $finish;
    end
    
endmodule