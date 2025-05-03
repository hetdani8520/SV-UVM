//queue pop_front() & pop_back() operations using dyn_arr
module dyn_arr_op;
  
  bit [4:0] dyn_arr[];
  bit [4:0] temp[];
  
  initial begin
    dyn_arr = '{1,2,3,4};
    //pop_back() - 1,2,3,4 --> 4 is pop_back using the below process()
    dyn_arr = new[dyn_arr.size() - 1] (dyn_arr);
    $display("arr=%p",dyn_arr);
    
    //pop_front() //1,2,3 --> 1 is pop_front using below process()
    dyn_arr.reverse(); //3,2,1
    dyn_arr = new[dyn_arr.size() - 1] (dyn_arr); //3,2
    dyn_arr.reverse(); //2,3
    $display("arr=%p",dyn_arr);
  end
  
endmodule