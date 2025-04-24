//write a systemverilog assertion such that a variable once asserted shouldn't be asserted again. by asserted again, it means if it was high it should remain high & if low remain low.
module x_stable_assertion;
  bit x;
  bit clk;
  
  //##1 is needed so that assertion doesnt trigger at first clock cycle(0) as past does not exist in the cycle 0
  a1:assert property(@(posedge clk) 
                    ##1 $stable(x)) $display("assertion passed at %tns",$time); else
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
      x=1;
      @(posedge clk); //5
      x=1;
      @(posedge clk); //15 
      repeat (2) @(posedge clk); //passes first at 15ns & then at 25ns 
      
      $finish;
    end
    
endmodule