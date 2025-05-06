module test_dpi1;
  //The function can be made pure as the foreign language does not use any SV data objects in its native C++ function body
  import "DPI-C" pure function void display();
  
  initial begin
    $display("in SV World");
    //invoke a C++ function in SV World
    display();
    $finish;
  end
endmodule
