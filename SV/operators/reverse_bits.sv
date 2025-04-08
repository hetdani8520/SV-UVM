//reverse bits of a 32-bit input integer

module reverse;
  function int reverse_bits(input int a);
    int rev;
    //this reverses bits of an input 32-bit number
    rev = {<<{a}};
    return rev;
  endfunction
  
  initial begin
    int a = 32'hDEADBEEF;
    $display("reversed number=%h",reverse_bits(a)); //32'hF77DB57B
  end
endmodule