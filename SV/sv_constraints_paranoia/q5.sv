class q5;
  rand int a; //values of var represents 10 diff colors
  rand int que[$]; //que to store random generated values so that unique values are produced by solver every iteration until 3
  
  constraint range {a inside {[1:10]};}
  
  constraint uniq { !(a inside {que});}
  
  function void post_randomize();
    que.push_front(a);
    if(que.size() == 3) begin
      que.delete();
    end
  endfunction
  
endclass

module test;
  q5 q5_h;
  
  initial begin
    q5_h = new();
    repeat(9) begin 
    assert(q5_h.randomize()) else
      $fatal(0,"randomization error");
    $display("a=%d",q5_h.a);
    end
  end
endmodule