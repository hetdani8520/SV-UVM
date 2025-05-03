class palindrome_binary;
  rand bit [15:0] bin;
  
  constraint palindrome {foreach(bin[i]){
    bin[i] == bin[15-i];}}
endclass
    
module test;
  palindrome_binary b1;
  
  initial begin
    b1=new();
    repeat(5) begin
    assert(b1.randomize()) else
      $fatal(0,"randomization error");
    $display("bin=%b",b1.bin);
    end
  end
endmodule