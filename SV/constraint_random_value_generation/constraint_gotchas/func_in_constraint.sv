//Currently this does not work on any simulators on edaplayground
//Code to produce a random variable with always only one bit set (can be easily done using system tasks $onehot, $countones, brian kernigham theorem etc)
//created a cnt_ones helper function to count number of ones in an expression
class func_in_constraint;
  rand bit [7:0] num;
  
  //bit length;
  
  //constraint num_ones_len {length == 1'd1;}
  
  constraint countones {cnt_ones(num) == 1'd1;}
  
  function automatic bit cnt_ones(input bit [7:0] in_data);
    for(cnt_ones=0;in_data!=0;in_data=in_data>>1)
      cnt_ones+= in_data&1;
  endfunction
endclass

module test;
  func_in_constraint f1;
  
  initial begin
    f1=new();
    
    repeat(5) begin
      assert(f1.randomize()) else
        $fatal(0,"f1::randomization failed");
      $display("randomized num value with countones=1 is:%d",f1.num);
    end
  end
endmodule