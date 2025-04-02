//Deep copy
class Statistics;
  time startT, stopT;
  
  function
  function Statistics copy();
    copy = new();
    copy.startT = startT;
    copy.stopT = stopT;
  endfunction
endclass


class Transaction;
  bit [31:0] addr, crc, data[8];
  Statistics stats; //nested object (pointer to statistics class)
  static int count=0;
  int id;
  
  function new();
    stats = new();
    id = count++;
  endfunction
  
  //copy function
  function Transaction copy();
    copy=new();                 //construct a dest obj
    copy.addr= addr;
    copy.crc = crc;
    copy.data = data;
    copy.stats = stats.copy();  //this calls Statistics::copy
  endfunction
  
endclass

module deep_copy;
  Transaction src, dst;
  
  initial begin
    src=new(); //src object
  src.stats.startT = 42;
  src.stats.stopT  = 96;
    dst = src.copy();         //deep copy of dst object
    $display("%d",dst.stats.startT); //42(src)
    $display("%d",dst.stats.stopT);  //96(src)
  src.stats.startT = 32;
  src.stats.stopT  = 78;
    //updating src object properties/nested obj properties above will now not update dst object due to deep copy of nested objects
    $display("%d",dst.stats.startT); //42(dst)
    $display("%d",dst.stats.stopT);  //96(dst)
  end
endmodule