//Problem:-Perform the randomisation of a variable in such a way that it always generates odd members with a condition having difference between current value and previous value is equal to 4.
class crv_basic2;
  rand bit [4:0] cur_val;
  bit [4:0] prev_val=5'd1; //for first iteration prev_val  has to be set to 1 for the solver to be able to generate next numbers with a diff of 4 from the previous one
  
  constraint val{cur_val != 5'd0;
                 prev_val != 5'd0;
                 cur_val % 2 != 0;
                 (cur_val - prev_val) == 5'd4;} //diff between the cur & prev val should be 4
  
  function void post_randomize();
    prev_val = cur_val;  //cur_val becomes prev_value after RNG
  endfunction
endclass

module crv_basic_test2;
  crv_basic2 c_h1;
  
  initial begin
  c_h1=new();
    
    repeat(5) begin
      assert(c_h1.randomize()) else
        $fatal(0,"crv_basic::randomization failed");
      $display("cur value=%d",c_h1.cur_val);
    end
  end
endmodule
