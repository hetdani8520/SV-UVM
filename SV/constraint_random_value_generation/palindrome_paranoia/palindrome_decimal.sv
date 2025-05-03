class palindrome_decimal;
  rand int unsigned dec;
  rand shortint unsigned x,y;
  
  constraint reverse {reverse_dec_num(x) == y;}
  
  constraint palindrome {dec[31:16] == y; //16-bit reverse
                         dec[15:0] == x;  //16-bit original
                        }
  
  function shortint unsigned reverse_dec_num(input shortint in);
    shortint rem=0;
    while(in > 0) begin
      rem = in%10; //23/10=> rem=3
      reverse_dec_num = reverse_dec_num*10 + rem; //shift lsb to msb
      in = in/10; //23/10 => quotient = 2
    end
  endfunction
  
endclass
    
module test;
  palindrome_decimal d1;
  
  initial begin
    d1=new();
    repeat(5) begin
      assert(d1.randomize()) else
      $fatal(0,"randomization error");
      $display("dec=%d",d1.dec);
    end
  end
endmodule