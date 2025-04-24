//Write a property/assertion to check if signal is toggling
module x_toggles_assertion;
  bit x;
  bit clk;
  
  //##1 is needed so that assertion doesnt trigger at first clock cycle(0) as past does not exist in the cycle 0
  a1:assert property(@(posedge clk) 
                   1'b1 |-> ##1  x != $past(x,1)) $display("assertion passed at %tns",$time); else
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
      @(posedge clk); //5
      x=1;
      @(posedge clk); //15 (passed at 15ns) x != $past(x)
      x=0;
      @(posedge clk);
      
      $finish;
    end
    
endmodule