//write a systemverilog constraint such that the number of bits toggled between prev & current number is 5. (implicitly asking us to make sure bits flips between two numbers = 5)
//bit flips can be tracked by doing a xor between current & prev number. If it is set that means values toggled
//Ref:- https://verificationacademy.com/forums/t/constraint-interview-question/44844/4?utm_source=debug.beehiiv.com&utm_medium=newsletter&utm_campaign=solution-another-constraint-challenge&_bhlid=a801878d0d2c707adbaef2669c26533a964b7997

class bits_flips_only_five;
  rand bit [15:0] num;
  
  constraint bit_flips_cnt {$countones(const'(num) ^ num) == 5;}
  
endclass
      
module tb;
  bits_flips_only_five c1;
  
  initial begin
    c1=new();
    repeat(5) begin
    assert(c1.randomize()) else
      $fatal(0,"randomization error");
      $display("num=%b",c1.num);
    end
      
  end
endmodule