//binary reverse
//decimal reverse
//arr reverse (using built-in function, two-pointer technique, streaming operator with correct elem slice)
module reverse_arr;
  bit [5:0] arr1[] = {5,3,6,7,10};
  bit [5:0] dec_vec = 63;
  bit [15:0] bin_vec = 16'h00FF;
  
  initial begin
    //bin reverse
    bit [15:0] rev= 0;
    $display("original bin vec=%b",bin_vec);
    for(int i=0;i<=15;i++) begin
      rev = rev << 1;
      rev = rev | (bin_vec&1'b1);
      bin_vec = bin_vec >> 1;
    end
    $display("reversed bin vec=%b",rev);
  end
  
  initial begin
    //dec reverse
    bit [15:0] pop = 0;
    bit [15:0] rev_dec = 0;
    $display("original dec vec=%d",dec_vec);
    while(dec_vec > 0) begin
      pop = dec_vec % 10; //rem (last digit)
      rev_dec = rev_dec*10 + pop;
      dec_vec = dec_vec / 10; //quotient (rem digits)
    end
    $display("reversed dec_vec=%d",rev_dec);
  end
  
  initial begin
    bit [5:0] rev_arr1[];
    int left = 0;
    int right = arr1.size() - 1;
    int temp = 0;
    $display("original arr1=%p",arr1);
    
    //meth-1 (streaming op)
    rev_arr1 = {<<6{arr1}};
    $display("rev arr1 using streaming op=%p",rev_arr1);
    
    //meth-2 (two-pointer method)
    while(left<right) begin
      temp = arr1[left];
      arr1[left] = arr1[right];
      arr1[right] = temp;
      left++;
      right--;
    end
    $display("rev arr1 using two-pointer technique=%p",arr1);
    
    //meth-3 (can also use built-in function reverse() - operate on actual arr)
  end
endmodule