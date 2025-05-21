//Write constraint for an integer array with 10 elements such that exactly 3 of them are same and rest are unique

//x elements same(each with value y) & rest elements unique
//x=3, y= any random same value, rest are unique

class misc_6;
  rand bit [3:0] arr[];
  
  rand bit [3:0] random;
  
  constraint size {arr.size() == 10;}
  
  constraint same_elem {arr.sum() with (int'(item==random)) == 3;}
  
  constraint rest_uniq {foreach(arr[i]){
    foreach(arr[j]){
      if((arr[i] != random && arr[j] != random) && (i!=j)){
        arr[i] != arr[j];}}}}
endclass
        
        
module test;
  misc_6 m1;
  
  initial begin
    m1=new();
    assert(m1.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",m1.arr);
  end
endmodule