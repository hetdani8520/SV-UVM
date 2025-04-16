//Credits:- https://verificationacademy.com/forums/t/how-to-disable-a-random-thread-out-of-three-thread-which-are-in-fork-join-any-block-once-one-thread-is-completed/37169
module disable_random_thread;
  process all_forks[$], active_forks[$];
  
  task automatic task1(input int delay);
    #delay;
    $display("thread 1 finished at %tns",$time);
  endtask
  
  task automatic task2(input int delay);
    #delay;
    $display("thread 2 finished at %tns",$time);
  endtask
  
  task automatic task3(input int delay);
    #delay;
    $display("thread 3 finished at %tns",$time);
  endtask
  
  initial
    begin
      fork
        begin
		  all_forks.push_back(process::self());
          task1(10);
        end
        
         begin
		   all_forks.push_back(process::self());
           task2(20);
         end
        
         begin
           all_forks.push_back(process::self());
           task3(30);
         end
      join_any
      foreach(all_forks[i]) begin
        if(all_forks[i].status != process::FINISHED) begin
          active_forks.push_back(all_forks[i]);
        end
      end
      active_forks[$urandom_range(active_forks.size() -1)].kill();
    end
  
endmodule