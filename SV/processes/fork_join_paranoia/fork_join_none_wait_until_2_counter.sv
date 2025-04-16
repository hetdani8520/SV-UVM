//This program waits for 2 threads to finish in a fork..join any using counter approach
//Dave says this approach is not thread-safe.
//For more info ref:- https://verificationacademy.com/forums/t/resume-simulation-when-any-2-threads-out-of-3-get-completed-within-fork-join-any/32572/6
module fork_join_any_wait_until_2_counter;
  
  int cnt=0; //static counter (very imp if we want the cnt value to be retained between multiple threads)
  
  task automatic task1(input int delay);
    #delay;
    $display("thread 1 will get completed at %t",$time);
    cnt++;
  endtask
  
  task automatic task2(input int delay);
    #delay;
    $display("thread 2 will get completed at %t",$time);
    cnt++;
  endtask
  
  task automatic task3(input int delay);
    #delay;
    $display("thread 3 will get completed at %t",$time);
    cnt++;
  endtask
  
  initial
    begin
      fork
        task1(10);
        task2(20);
        task3(30);
      join_none
      $display("outside fork..join_none");
      wait(cnt == 2); //wait until 2 processes have finished
      $display("2 tasks finished");
      disable fork //disable rest threads
      
    end
  
endmodule