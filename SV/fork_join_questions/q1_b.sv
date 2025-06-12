module q1_a;
  task thread1(input int delay);
    #delay;
    $display("thread 1 finished at %tns",$time);
  endtask
  
  task thread2(input int delay);
    #delay;
    $display("thread 2 finished at %tns",$time);
  endtask
  
  task thread3(input int delay);
    #delay;
    $display("thread 3 finished at %tns",$time);
  endtask
  
  task thread4(input int delay);
    #delay;
    $display("thread 4 finished at %tns",$time);
  endtask
  
  initial begin
    
    fork
      begin:T1
        thread1(10);
      end
      
      begin:T2
        thread2(20);
      end
      
      begin:T3
        thread3(30);
      end
      
      begin:T4
        thread4(40);
	  end
    join_any
    $display("fork-join_any finished at %tns",$time); //fork-join_any unblocks the parent thread until the earliest thread is finished
    $finish;
    end
endmodule