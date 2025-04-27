module reverse_a_string;
  
  function string str_rev(input string orig);
    string rev;
    //iterate over the sinput string from backwards & concatenate the result on everyy iteration
    for(int i=orig.len();i>=0;i--) begin
      rev = {rev,orig[i]};
    end
    return rev;
  endfunction
  
  initial begin
    string orig_in = "het"; //each charater in a string is stored as 8-bits
    $display("reverse of string %s IS %s",orig_in,str_rev(orig_in));
  end
endmodule