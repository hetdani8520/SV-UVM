//The random numbber generated using std::randomize() does not necessarily provide random stability
//Problem:-Randomize a class property without using rand or randc. (try std::randomize())
module std_rand;
  bit [3:0] a; //this is the std::randomize variable
  bit ret; //this var holds the return value from std::randomize function. 1:success, 0:failure 
  
  
  initial begin
    repeat(5) begin
      ret = std::randomize(a) with {a inside {[1:5]};};
      $display("return success from std::randomize func=%d",ret);
      $display("value of a from std::randomize func=%d",a);
    end
  end
endmodule