//Priority of soft constraints
//priority of soft constraint increases as we go down the hierarchy
class C;
  rand bit[2:0] a;
  constraint C_1 {soft a == 5;} //priority 0
endclass

class EC extends C;
  constraint EC_1 {soft a == 4;} //priority 1
endclass

class D;
  rand EC ech =new();
  
  constraint D_1 {soft ech.a == 3;} //priority 2
endclass

module tb;
  D dh;
  initial begin
    dh = new();
    repeat(5) begin
      assert(dh.randomize() with {soft dh.ech.a == 2;}) else //priority 3
      $fatal(0, "randomization error");
    $display("value of a=%d",dh.ech.a);
    end
  end
endmodule