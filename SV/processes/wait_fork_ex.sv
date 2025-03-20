//wait fork is a blocking assignment & can be used to wait for any spawned threads to finish execution
module wait_fork_ex;
  
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
    
    fork
      run_a();
      run_b();
    join_any

      wait fork; //blocking assign will cause wait until remainder child threads run_c() & run_b() complete
        $display("waiting for all threads to complete at time=%t",$time);
  end
  
endmodule