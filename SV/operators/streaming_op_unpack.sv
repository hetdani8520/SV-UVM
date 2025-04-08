//unpacking using streaming operators


module unpack;
  bit [7:0] unpacked_array[4];
  int packed_content;
  initial begin
    packed_content = 32'hDEADBEEF;
    //unpack 32-bit data into byte chunks into the array
    {>>{unpacked_array}} = packed_content;
    $display("unpacked array=%p",unpacked_array);
    //unpack 32-bit data, reverse bits of each byte of packed data & dump the unpacked content into the array
    {<<{unpacked_array}} = packed_content;
    $display("unpacked array(reversed content)=%p",unpacked_array);
  end
endmodule