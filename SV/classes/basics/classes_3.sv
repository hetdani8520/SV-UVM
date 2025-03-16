//Problem:- Write a subroutine to add two properties and assign it to third property.

class classes_3;
  bit [3:0] a,b;
  bit [4:0] sum;
  
  function void calc_sum(input bit [3:0] a, input bit [3:0] b);
    this.a=a;
    this.b=b;
    this.sum = this.a + this.b;
    $display("sum=%d",this.sum);
  endfunction
endclass

module test;
  classes_3 c3_h;
  
  initial begin
  c3_h=new();
    c3_h.calc_sum(15,15); //sum=30
  end
  
endmodule
