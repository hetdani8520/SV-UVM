//Method-1:Disable single/multiple threads using fork..join begin..end guards as those guards restrict the scope for "disable" to be active
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
      run_a();
      run_b();
    join_any

//Method-1:To prevent child thread task run_b from getting killed by disable fork constrain the scope of disable to child thread task run_c (VVImp: you need to encapsulate it under fork..join & begin..end for it to work)
//disable run_c() & leave run_a() & run_b() alone
fork 
  begin //disable label can also be used to stop specific threads under label scope
    fork
      run_c();
    join_none
      
    disable fork; //This will disable run_c & run_b child threads
  end
join      
      $display("disabled all threads at time=%t",$time);
  end
  
endmodule