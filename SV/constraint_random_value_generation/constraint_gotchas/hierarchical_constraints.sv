//hierarchical constraints in aggregate class structure
//Note:null member objects are not randomized but remain null
class a;
  rand bit a;
endclass

class b;
  rand a a1 =new(); //must exist before randomization
  bit [1:0] b;
  constraint c2_a_aggregate {a1.a dist {0:= 50, 1:= 50};} //constraints can reference member objects
endclass

module tb;
  b bh;
  initial begin
    bh=new();
    repeat(6) begin
      //assert(bh.randomize() with {a1.a == 1;}) else
      //$fatal(0,"randomization error");
       assert(bh.randomize()) else
      $fatal(0,"randomization error");
      $display("a=%b",bh.a1.a);
    end
  end
endmodule
