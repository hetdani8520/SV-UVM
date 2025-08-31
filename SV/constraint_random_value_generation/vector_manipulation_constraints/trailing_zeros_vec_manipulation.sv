class trailing_zeros_vec_manipulation;
  rand bit [31:0] a;
  rand bit [4:0] start_idx;
  rand bit [4:0] width;
  
  //bound (not req here as width constraint never lets it overflow)
  constraint bound {start_idx + width - 1 < 31;}
  
  //start_idx
  constraint start_idx_constraint {start_idx == 0;}
  
  //width
  constraint width_constraint {width inside {[5:10]};}
  
  //trailing zeros & rest are ones for the moment
  constraint zeros {foreach(a[i]){
    if(i>=start_idx && i<=start_idx + width - 1){
      a[i] == 0;}
      else{
    a[i] == 1;}}}
endclass
      
      
module tb;
  a1 ah;
  
  initial begin
    ah = new();
    repeat(5) begin
    assert(ah.randomize()) else
      $fatal(0,"randomization error");
    $display("start_idx=%d",ah.start_idx);
    $display("width=%d",ah.width);
    $display("a=%b",ah.a);
    end
  end
endmodule