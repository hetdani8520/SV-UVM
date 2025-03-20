//Method:- scope of disable fork can also be constrained using appropriate label that define scope.
//In below example, using label will disable child thread run_b under "dis_two" label scope while child thread run_a is left alone to complete & is now outside disable scope
module disable_threads_using_guard;
  
  task run_a();
    #20;
    $display("time for task a to finish:%t",$time);
  endtask
  
  task run_b();
    #50;
    $display("time for task b to finish:%t",$time);
  endtask
  
  task run_c();
    #100;
    $display("time for task c to finish:%t",$time);
  endtask
  
  initial 
    begin
    
      
    fork
      run_c();
    join_none
    
    fork:dis_two
      run_a();
      run_b();
    join_any
      
      disable dis_two; //This will disable child thread run_b under "dis_two" label scope while child thread run_a is left alone to complete & is now outside disable scope      
      $display("disabled all threads at time=%t",$time);
  end
  
endmodule