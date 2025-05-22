module sv2cpp2_return;
  
  import "DPI-C" pure function bit display(input bit in);
  
  initial begin
    bit outfromcpp;
    $display("inside SV world");
    outfromcpp = display(1); //pass by value
    $display("outfromcpp=%d",outfromcpp);
    #1;
    $finish;
  end
  
endmodule