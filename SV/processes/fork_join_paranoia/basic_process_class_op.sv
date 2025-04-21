module process_class;

  initial begin
    create_n_thread(5);
  end
  
  task automatic create_n_thread(int n);
    process job[] = new[n];
      
      for(int i=0;i<n;i++) begin
        automatic int k = i;
        fork
          begin
            job[k] = process::self(); //get pid for each thread/process
            $display("thread %d created at time %t",k,$time);
          end
        join_none;
      end
      
      for(int j=0;j<n;j++) begin //wait for all the processes to start
        wait(job[j] != null);
      end
      
      job[0].await(); //wait for the first process to finish
      
      for(int m=0;m<n;m++) begin //kill the remaining processes
        if(job[m].status != process::FINISHED) begin
          job[m].kill();
      end
      end
    endtask
endmodule