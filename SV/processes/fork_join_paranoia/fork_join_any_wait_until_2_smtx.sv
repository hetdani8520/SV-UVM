//wait for 2 threads to finish in fork..join_any using smtx.
//For more info ref:- https://verificationacademy.com/forums/t/resume-simulation-when-any-2-threads-out-of-3-get-completed-within-fork-join-any/32572/6
//There are three parallel threads running in fork-join_any. I want to come-out from that when any two threads get completed.

module fork_join_any_wait_until_2_smtx;
  
  semaphore smtx;
  
  task automatic task1(input int delay);
    #delay;
    $display("thread 1 will get completed at %t",$time);
    smtx.put(1);
  endtask
  
  task automatic task2(input int delay);
    #delay;
    $display("thread 2 will get completed at %t",$time);
    smtx.put(1);
  endtask
  
  task automatic task3(input int delay);
    #delay;
    $display("thread 3 will get completed at %t",$time);
    smtx.put(1);
  endtask
  
  initial
    begin
      smtx=new(0);
      fork
        task1(10);
        task2(20);
        task3(30);
      join_any
      $display("outside fork..join_any");
      smtx.get(2); //waits for 2 threads to finish (threads finish when they put the semaphore keys back into the bucket)
      $display("2 tasks finished");
      disable fork; //rest threads killed after 2 are finished
      
    end
  
endmodule