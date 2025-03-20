class randc_using_rand;
  rand bit [3:0] a;
  bit [3:0] que[$];
  
  constraint ele {!(a inside {que});}
  
  function void post_randomize();
    que.push_back(a);
    if(que.size() == 16) begin
      que = {}; //delete sntire que
    end
  endfunction
endclass

module test;
  randc_using_rand r1;
  
  initial begin
    r1=new();
    repeat(17) begin
    assert(r1.randomize()) else
      $fatal(0,"r1::randomization failed");
      $display("value of cyclic random a=%d",r1.a);
    end
  end
endmodule