//Write a constraint to generate an address where 9 bits are always set to 1, and sequences of 111 or 000 should not occur in a 16-bit address.

class addr_gen_without_seq;
  rand bit [15:0] addr;
  
  //addr with 9-bits always set to 1
  constraint c1 {$countones(addr) == 9;}
  
  //seqeunces of 111 & 000 should not occur in a 16-bit address
  //iteration capped at index 12 to avoid out of bounds error
  constraint c2{foreach(addr[i]){
    if(i>=0 && i <= 12){
      {addr[i],addr[i+1],addr[i+2]} != 3'b000;
      {addr[i],addr[i+1],addr[i+2]} != 3'b111;
    }
  }}
endclass
    
module tb;
  addr_rand a1;
  
  initial begin
    a1=new();
    repeat(5) begin
    assert(a1.randomize()) else
      $fatal(0,"randomization failed");
    $display("addr(bin)=%b & addr(dec)=%d",a1.addr,a1.addr);
  end
  end
endmodule