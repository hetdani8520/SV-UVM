//Write	an	assertion	check	to	make	sure	that	a	signal	is	high	for	a
//minimum	of	2	cycles	and	a	maximum	of	6	cycles.
module a_high_between_2_to_6_cycle;
  bit a;
  logic clk;
  
  a1:assert property(@(posedge clk)
                     $rose(a) |-> a[*2:6] ##1 (a==0)) 
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
    @(posedge clk); //5
    a=1;
    @(posedge clk); //15
    @(posedge clk); //25 
    @(posedge clk); //35
    @(posedge clk); //45
    @(posedge clk); //55
    @(posedge clk); //65
    a=0;
    @(posedge clk); //75 (passed at 75ns)
    @(posedge clk); //80
    
    $finish;
  end
endmodule