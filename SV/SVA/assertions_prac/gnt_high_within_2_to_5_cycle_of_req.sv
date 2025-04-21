//Write	an	assertion	which	checks	that	once	a	valid	request	is	asserted	by the	master,	the	arbiter	provides	a	grant	within	2	to	5	clock	cycles
module gnt_high_within_2_to_5_cycle_of_req;
  bit req, gnt;
  logic clk;
  
  a1:assert property(@(posedge clk)
                     $rose(req) |=> ##[2:5] $rose(gnt)) 
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
    req=0;
    gnt=0;
    @(posedge clk); //5
    req=1;
    @(posedge clk); //15
    @(posedge clk); //25
    @(posedge clk); //35
    gnt=1;
    @(posedge clk); //45 (first $rose(gnt) captured here (passed))
    @(posedge clk); //55
    
    $finish;
  end
endmodule