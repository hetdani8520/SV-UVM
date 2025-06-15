module q5_semaphores;
  semaphore smtx;
  
  initial begin
    smtx = new(2); //allocated 2 keys => only 2 processes can run concurrently at a time
    
    fork
      begin:B
        smtx.get(1);
        $display("Process_B completed");
        smtx.put(1);
      end
      
      begin:A_C
        smtx.get(1);
        $display("Process_A completed");
        $display("Process_C completed");
        smtx.put(1);
      end
      
      begin:D
        smtx.get(2);
        $display("Process_D completed");
        smtx.put(2);
      end
    join
  end
  
endmodule