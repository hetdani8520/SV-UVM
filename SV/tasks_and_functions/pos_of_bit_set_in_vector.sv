//system verilog function to find position of bits set in a vector
//easy method:- array.find_index() with (item == 1); (this will also return a queue of positions of bit set in an unpacked array)
module positions_of_bit_set;
  
  function void pos_of_bit_set_in_vec(input bit [31:0] a, ref bit [5:0] que_pos[$]);
    foreach(a[i]) begin
      if(a[i] == 1'b1) begin
        que_pos.push_back(i);
      end
    end
  endfunction
  
  initial begin
    bit [5:0] que_pos[$];
    bit [31:0] a = 32'hFFFF0000;
    //function call to find positions of bit set in a vector
    pos_of_bit_set_in_vec(a,que_pos);
    $display("position of bit set in vec a=%p",que_pos);
  end
endmodule