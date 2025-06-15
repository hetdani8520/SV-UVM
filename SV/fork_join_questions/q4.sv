//TODO:Misc q1:- //A,B,C,D threads
//B should start after A
//D should start after B & C

//Potential bugs are:
//1)If D wins arbitration then it can get executed before even A_B & C process starts which will be undesired result.

module q4;
  semaphore smtx;
  
  initial begin
    smtx=new(2); //initialized with 2 keys => only 2 processes are allowed to run concurrently
    fork
    
    begin:A_B
      smtx.get(1);
      $display("thread A completed");
      $display("thread B completed");
      smtx.put(1);
    end
      
    begin:C
      smtx.get(1);
      $display("thread C completed");
      smtx.put(1);
    end
      
    begin:D
      smtx.get(2);
      $display("thread D completed");
      smtx.put(2);
    end
    
    join
  
  end
  
  
endmodule