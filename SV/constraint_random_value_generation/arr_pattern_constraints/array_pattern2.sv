//arr pattern:- 101010101010....
class array_pattern_2;
  rand bit arr[];
  
  constraint c1_size {arr.size() == 10;}
  
  constraint c1_ele {foreach(arr[i]){
    if(i[0] == 1)
      arr[i] == 0;
      else
        arr[i] == 1;}}
endclass
    
module test;
  array_pattern_2 a1;
  
  initial begin
    a1=new();
    assert(a1.randomize()) else
      $fatal(0,"randomize::eror");
    $display("arr=%p",a1.arr);
  end
endmodule