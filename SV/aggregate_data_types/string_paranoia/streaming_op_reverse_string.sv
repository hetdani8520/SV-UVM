module reverse_a_string;
  
  function string str_rev(input string orig);
    string rev;
    rev = {<<8{orig}}; //reverse the input string at 8-bit slices
    return rev;
  endfunction
  
  initial begin
    string orig_in = "het"; //each charater in a string is stored as 8-bits
    $display("reverse of string %s IS %s",orig_in,str_rev(orig_in));
  end
endmodule