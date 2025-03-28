//generate onehot vector using SV constraints (using $onehot system task)
class onehot1;
  rand bit [4:0] a;
  
  constraint c1 {$onehot(a);}
  
  function disp();
    $display("a=%d",a);
  endfunction
endclass

module onehot1;
  onehot1 h1;
  
  initial begin
    h1=new();
    $display("-----------method-1-------------------");
    repeat(5) begin
    assert(h1.randomize()) else
      $fatal(0,"h1:randomization failed");
    h1.disp();
    end
  end
endmodule

//generate onehot vector using SV constraints (using $countones system task)
class onehot2;
  rand bit [4:0] a;
  
  constraint c1 {$countones(a) == 1;}
  
  function disp();
    $display("a=%d",a);
  endfunction
endclass

module onehot2;
  onehot2 h2;
  
  initial begin
    h2=new();
    $display("-----------method-2-------------------");
    repeat(5) begin
      assert(h2.randomize()) else
        $fatal(0,"h2:randomization failed");
    h2.disp();
    end
  end
endmodule

//generate onehot vector using SV constraints (left-shift 1 by random amt)
class onehot3;
  rand bit [4:0] a;
  rand bit [4:0] shift;
  
  constraint c1 {a == (1 << shift);}
  
  function disp();
    $display("a=%d",a);
  endfunction
endclass

module onehot3;
  onehot3 h3;
  
  initial begin
    h3=new();
    $display("-----------method-3-------------------");
    repeat(5) begin
      assert(h3.randomize()) else
        $fatal(0,"h3:randomization failed");
    h3.disp();
    end
  end
endmodule

//generate onehot vector using SV constraints (n&(n-1) == 0)
class onehot4;
  rand bit [4:0] a;
  rand bit [4:0] shift;
  
  constraint c1 {a!=0;
    (a&(a-1)) == 0;}
    				
  function disp();
    $display("a=%d",a);
  endfunction
endclass

module onehot4;
  onehot4 h4;
  
  initial begin
    h4=new();
    $display("-----------method-4-------------------");
    repeat(5) begin
      assert(h4.randomize()) else
        $fatal(0,"h4:randomization failed");
    h4.disp();
    end
  end
endmodule