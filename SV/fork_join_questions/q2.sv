module q2_wait_for_thread;
  semaphore smtx = new(0);  
  
  initial begin
      
      fork
        begin:T1
          #10;
          $display("thread 1");
          smtx.put(1);
        end
        
        begin:T2
          #10;
          $display("thread 2");
          smtx.put(1);
        end
        
        begin:T3
          #30;
          $display("thread 3");
          smtx.put(1);
        end
        
      join_none //can alternatively use fork-join_any as well
      smtx.get(2); //wait for any 2 threads to complete
      $display("two threads finished now");
      disable fork; //disable rest threads
      smtx = null; //semaphore smtx available for reuse
  end
endmodule