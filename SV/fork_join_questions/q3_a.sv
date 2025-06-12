//kill other threads after one thread complete execution

module q3_a;
  process all_forks[$];
  process active_forks[$];
  
  initial begin
      
      fork
        begin:T1
          all_forks.push_back(process::self()); //capturing pid of thread
          #10;
          $display("thread 1");
        end
        
        begin:T2
          all_forks.push_back(process::self()); //capturing pid of thread
          #10; 
          $display("thread 2");
        end
        
        begin:T3
          all_forks.push_back(process::self()); //capturing pid of thread
          #30;
          $display("thread 3");
        end
        
      join_any
	  //disable fork; //simplest way to disable rest threads
    
      //how to disable rest "all" threads using process class
    foreach(all_forks[i]) begin
      if(all_forks[i].status != process::FINISHED) begin
        active_forks.push_back(all_forks[i]);
      end
    end
    //kill all active threads
    foreach(active_forks[i]) begin
      active_forks[i].kill();
    end
  end
endmodule