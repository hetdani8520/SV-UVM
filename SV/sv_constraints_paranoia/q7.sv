class q7;
  parameter int N = 300;
  rand int arr[300];
  
  constraint element {foreach(arr[i]){
    arr[i] inside {[0:4]};}}
    
  //occurrence constraint on each element
    constraint occ_1 {arr.sum() with (int'(item==0)) > 40;
                      arr.sum() with (int'(item==1)) > 40;
                      arr.sum() with (int'(item==2)) > 40;
                      arr.sum() with (int'(item==3)) > 40;
                     }
  
  //1,2,3,4 cannot occur consecutively
    constraint no_consecutive {foreach(arr[i]){
      if((arr[i] == 1 || arr[i] == 2 || arr[i] == 3 || arr[i] == 4) && i>0){
        arr[i] != arr[i-1];}}}
endclass
        
module test;
  q7 q7_h;
  
  initial begin
    q7_h = new();
    assert(q7_h.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",q7_h.arr);
  end
endmodule