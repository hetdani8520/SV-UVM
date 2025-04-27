module max_length_between_repeating_char_in_strings;
  
  function bit [7:0] max_len(input string str_in);
    int max_value=0;
    int max_idx=0;
    string repeating_char;
    int cnt=0;
    
    for(int i=0;i<str_in.len();i++) begin
      cnt=0;
      for(int j=i;j<str_in.len();j++) begin //make sure to start inner loop from j=i to count the first repeating character as well
        if(str_in[i] != str_in[j]) begin
          break;
        end
        cnt++;
      end
      
      if(cnt > max_value) begin
        max_value = cnt;
        max_idx = i;
        //repeating_char = str_in[i];
      end
    end
    return max_value; //return max_len between two consecutive repeating char in string
  endfunction
  
  initial begin
    string inp = "deadddddddddddbeef";
    $display("max_len between two consecutive repeating char in string is %d",max_len(inp));
  end
endmodule