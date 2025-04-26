//string randomization (string data type randomization is not supported by constraint solver based on SV LRM spec)
//Below is an alternate way of randomizing a string by actually randomizing the ASCII range that maps to aA-zZ char range.
//Credits for the solution:- https://verificationacademy.com/forums/t/can-we-randomize-strings-in-systemverilog/31984
class string_randomization;
  rand bit [7:0] arr[];
  
  constraint size {arr.size() == 7;}
  
  constraint string_logic{foreach(arr[i]){
    arr[i] inside {[65:90],[97:122]};}} //ASCII code conversion:65-90(A-Z), 97-122(a-z)
                         
    
    function string getstr();
      string str;
      foreach(arr[i]) begin
      str = {str,string'(arr[i])};
      end
      return str;
    endfunction
    
endclass
                          
module test;
  string_randomization s1;
  
  initial begin
    string new_str;
    s1=new();
    assert(s1.randomize()) else
      $fatal(0,"randomization error");
    new_str = s1.getstr();
    $display("string=%s",new_str);
  end
endmodule