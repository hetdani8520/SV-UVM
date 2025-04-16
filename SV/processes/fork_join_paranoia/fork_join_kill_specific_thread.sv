//Kill a specific thread inside fork..join using disable label
//One more way is to encapsulate the thread to be killed into a parent fork & kill it using disable fork.
module fork_join_kill_specific_thread;
  
  task automatic task1(input int delay);
    #delay;
    $display("thread 1 finished at %t",$time);
  endtask
  
  task automatic task2(input int delay);
    #delay;
    $display("thread 2 finished at %t",$time);
  endtask
  
  task automatic task3(input int delay);
    #delay;
    $display("thread 3 finished at %t",$time);
  endtask
  
  initial
    begin
      
      fork
        begin:t1
          task1(10);
        end
        
        begin:t2
          task2(20);
        end
        
        begin:t3
          task3(30);
        end
            
        disable t2; //specify specific thread to be disabled inside fork..join 
      join
      
    end
  
endmodule