class q11;
  rand int arr[8];
  
  constraint elem {foreach(arr[i]){
    i % 2 == 0 -> arr[i] == fact(i);
    i % 2 != 0 -> arr[i] == fact(i);}}
    
    
    function int fact(input int a);
       int fac = 0;
       if(a==0) begin
         fac = 1;
         return fac;
       end
       else begin
         fac = 1;
       for(int i=1;i<=a;i++) begin
         fac*=i;
       end
       return fac;
       end
    endfunction
  
endclass
      
      
module tb;
  q11 q11h;
  
  initial begin
    q11h=new();
    //repeat(10) begin
    assert(q11h.randomize()) else
      $fatal(0,"randomization error");
    //$display("a=%d",ah.a);
      $display("arr=%p",q11h.arr);
    //end
  end
endmodule