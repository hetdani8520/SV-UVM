//write a systemverilog constraint to produce a 32-bit vector with 2 bits different.

class vect_32;
  rand bit [31:0] a;
  
  //vars to select random bits to randomize from vector
  rand bit [4:0] first_bit;
  rand bit [4:0] sec_bit;
  
  constraint bits {first_bit inside {[0:31]};
              sec_bit inside {[0:31]};}
  
  //2 bits diff
  constraint range {a[first_bit] != a[sec_bit];}
  
  //other bits same
  constraint other_bits_same {foreach(a[i]){
    if(i!= (first_bit || sec_bit)){
      a[i] == 1;}}}
      
endclass
      
module test;
  vect_32 v1;
  
  initial begin
    v1=new();
    assert(v1.randomize()) else
      $fatal(0,"randomization error");
    $display("first bit=%d",v1.first_bit);
    $display("sec bit=%d",v1.sec_bit);
    $display("vec=%b",v1.a);
  end
endmodule