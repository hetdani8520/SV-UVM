module palindrome_string;
  string in="";
  
  function bit is_palindrome(input string in);
    string rev="";
    /*
    //method-1:reverse a string
    for(int i=in.len()-1;i>=0;i--) begin
      rev = {rev,in[i]};
    end
    */
    
    //method-2:reverse a string
    //each char in a string is 8-bits wide so 8-bit slice reverse should also reverse the string
    rev = {<<8{in}};
    
    //remember str1.compare(str2) returns 0 if string compare is successful
    //second way of comparing strings str1 == str2 (case equality) - I think this is under the hood doing ascii compare between strings (returns 1 if successful)
    if(in == rev) begin
      $display("string is palindrome, reverse_string=%s,orig=%s",rev,in);
    end
    else begin
      $display("string is NOT palindrome, reverse_string=%s,orig=%s",rev,in);
    end
  endfunction
  
  initial begin
    string dem = "het";
    is_palindrome(dem);
  end
endmodule