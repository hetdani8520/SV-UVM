//111000111000....
//solve with post_randomize() procedural logic
class array_pattern4;
  rand bit arr[];  //arr holding the pattern
  int rpt_cnt = 3; //This can be fixed if pattern rpt_cnt is known
  int arr_idx; //index into the arr
  int num_groups;
  
  constraint size {arr.size() == num_groups * 3;}
  
  function void post_randomize();
    while(arr_idx < arr.size()) begin //as far as arr_idx is less than size of arr
      //This logic fills arr with 1 based on the rpt_cnt as terminating condition
      for(int j=0;j<rpt_cnt;j++) begin
        arr[arr_idx] = 1;
        arr_idx++;
      end
      
      //This logic fills arr with 0 based on the rpt_cnt as terminating condition
      for(int j=0; j<rpt_cnt;j++) begin
        arr[arr_idx] = 0;
        arr_idx++;
      end
      
      //rpt_cnt+=3;
    end
  endfunction
  
  
endclass
      
module test;
  array_pattern4 a4;
  
  initial begin
    a4=new();
    a4.num_groups = 8;
    assert(a4.randomize()) else
      $fatal(0,"randomization error");
    $display("arr=%p",a4.arr);
  end
  
endmodule

