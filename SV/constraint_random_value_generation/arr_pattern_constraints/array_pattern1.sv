//Write a constraint to generate 1100110011001100

class pattern_1;
  rand bit arr[];
  
  constraint c1 {arr.size() == 16;}
  
  constraint c2 {foreach(arr[i]){
    arr[0] == 1'b1; //first element is set to 1 
    arr[1] == 1'b1; //second element is set to 1
    /* simplyfying the redundant logic
                 if(i>1 && i % 2 == 0){
                   arr[i] == ~(arr[i-2]);
                 }
                   if(i>1 && i % 2 != 0){
                     arr[i] == ~(arr[i-2]);
                   }}}
                   */
    if(i>1){
      arr[i] == ~(arr[i-2]);
    }}}
endclass

module tb;
  pattern_1 p1;
  
  initial begin
    p1=new();
    repeat(16) begin
    assert(p1.randomize()) else
      $fatal(0,"randomization failed");
    end
    $display("arr=%p",p1.arr);
  end
endmodule