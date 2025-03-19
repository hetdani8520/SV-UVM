//Problem:- Write a piece of code with class having some properties of rand type (Note: some of the properties to be randc type and some properties to be of non-rand type). 
//properties defined as randc are solved first before rand properties by the solver.
//Note:Make sure to not have inter-dependent constraints between rand & randc properties as those might get "skipped/ignored" by solver
class crv_basic;
  rand bit [1:0] a;  //non-cyclic rand
  randc bit [3:0] b; //cyclic rand
  
  //a should always be 2
  constraint a_c{a == 2'd2;}
  
  function void disp_rand;
    $display("a=%d,b=%d",a,b);
  endfunction
endclass

module test_crv_basic;
  crv_basic c_h;
  
  initial begin
    c_h = new(); //create object once & invoke randomize() multiple times on the same object to be able to observe consistent behaviour for cyclic rand properties.
    repeat(16) begin
  //randomize the rand/randc various by invoking built-in func
  assert(c_h.randomize()) else
    $fatal(0,"crv_basic::randomization failed");
    c_h.disp_rand();
    end
  end
endmodule