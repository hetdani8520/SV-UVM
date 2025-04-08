//packing using streaming operators
//During packing streaming operators looks at the size of LHS & packs accordingly based on the size of LHS. (if slice is explicitly not specified in when using streaming operators)
//ref:- https://www.consulting.amiq.com/2017/05/29/how-to-pack-data-using-systemverilog-streaming-operators/
module pack;
  bit [7:0] array[4];
  int packed_content;
  bit [7:0] packed_content_8;
  initial begin
    array = '{8'h1,8'h2,8'h3,8'h4};
    //packing array of bytes into an int
    packed_content = {>>{array}};
    $display("packed_content=%h",packed_content);
    //reversing array of bytes(slice-8bit) & packing it into an int
    packed_content = {<<8{array}}; //change slice to 16 just by replacing 8 with 16
    $display("packed_content(reverse,slice-8bits)=%h",packed_content);
    //reverse the bits of a byte & pack the result
    packed_content_8 = {<<{8'hDE}};
    $display("packed_content(reverse bits of byte)=%h",packed_content_8);
  end
endmodule