//reverse bits within each byte of a 64-bit number
module reverse_bits_within_byte;
  bit [7:0] que[$];
  function logic [63:0] reverse_bits_within_byte(input logic [63:0] input_data);
    bit [7:0] data;
    logic [63:0] data_out;
    //This logic reverses bits within each byte of a 64-bit number
    for(int i=0;i<64;i+=8) begin
      data = {<<{input_data[i+:8]}};
      que.push_front(data); //push per byte reversal data onto queue
    end
    $display("que = %p",que);
    //pack the data in que to get reversed data
    data_out = {>>{que}};
    //$display("data_out = %b",data_out);
    return data_out;
  endfunction
  
  initial begin
    $display("reverse output = %b",reverse_bits_within_byte(64'hBEEFCAFEDEADBEEF));
  end
endmodule