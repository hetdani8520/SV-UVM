//111000111000...
class array_pattern4_hard_constraint;
  rand bit arr[];
  int num_groups;
  rand bit [5:0] block_index;
  
  
  constraint size {arr.size() == num_groups * 3;}
  
  constraint pattern {foreach(arr[i]){
    if((i%6) < 3){ //here 6 is based on block size that repeats itself (111000..)
                          arr[i] == 1;
                        }
                        else{
                          arr[i] == 0;
                        }}}
  
endclass
                          
module test;
  array_pattern4_hard_constraint a4;
  
  initial begin
    a4=new();
    a4.num_groups = 5;
    assert(a4.randomize()) else
      $fatal(0, "randomization error");
    $display("arr=%p",a4.arr);
  end
endmodule