class q2;
  parameter int N = 10;
  rand int arr[N];
  rand int x;
  
  //range of values
  constraint range {foreach(arr[i]){
    arr[i] inside {[0:50]};}
    x inside {[0:50]};}
  
  //x elem in arr same
  constraint same {arr.sum() with (int'(item==x)) == 3;}
  
  //other elem in arr unique
  constraint uniq {foreach(arr[i]){
    				foreach(arr[j]){
                      if((arr[i] != x && arr[j] != x) && (i!=j)){
                        arr[i] != arr[j];}}}}
  
endclass
                        
module test;
  q2 q2_h;
  
  initial begin
    q2_h = new();
    repeat(3) begin
    assert(q2_h.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p & repeating elem=%d",q2_h.arr,q2_h.x);
    end
  end
endmodule