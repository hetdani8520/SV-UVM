//constraint a 16 bit number such that all the 1's that it has must be consecutive. It needs to have at least one 1.

class consecutive_ones;
  rand bit [15:0] a;
  
  rand bit [3:0] start_idx;
  
  rand bit [3:0] width;
  
  constraint random_consecutive_ones {foreach(a[i]){
    if(i>=start_idx && i<=(start_idx + width - 1)){
      a[i] == 1;} else{
      a[i] == 0;}}}
  
  //constraint protects against out-of-bounds access when assigning 1s to a[i] by ensuring the start_idx + width - 1 <= 15.    
  constraint control_vars {start_idx <= (16 - width);}
endclass
      
      
module test;
  consecutive_ones c1;
  
  initial begin
    c1=new();
    repeat(3) begin
    assert(c1.randomize()) else
      $fatal(0,"randomization error");
      $display("start_idx=%d",c1.start_idx);
      $display("width=%d",c1.width);
    $display("a=%b",c1.a);
  end
  end
endmodule