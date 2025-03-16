//Shallow copy:- Here a new object is created & all members are copied. However, any internal object members are referenced not copied.
//Note:- shallow copy copies the object BUT not any objects it "points" to.
//
//

class statistics;
time startT, stopT;
endclass

class txn;
  bit [31:0] addr, crc, data[8];
  statistics stats; //internal object member
endclass

module test;
  txn src,dst;
  
  initial begin
  src=new();
  src.stats=new();
  src.stats.startT=24;
    dst = new src; //shallow copy (this will create a copy of all the members of txn except for stats as it is an internal obj member which will only be referenced but NOT copied) 
  dst.stats.startT=48;
  $display(src.stats.startT);
  end

endmodule
