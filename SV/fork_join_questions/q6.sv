//Misc q3: Write a multi-threaded code with one thread printing all even numbers and the other all odd numbers. The output should always be in sequence Eg :  0,1,2,3,4… etc

module q6;
  semaphore smtx;
  
  bit [3:0] arr[10];
  bit [3:0] shared_var=0;
  
  initial begin
    smtx=new(1); //allocated & initialized with 1 key => only 1 process can access concurrently
  while(shared_var < $size(arr)) begin
    fork
      begin:even
          smtx.get(1);
          if(shared_var % 2 == 0) begin
          arr[shared_var] = shared_var;
          end
          shared_var++;
        //$display("arr(even)=%p",arr);
        smtx.put(1);
      end
      
      begin:odd
        smtx.get(1);
         if(shared_var % 2 != 0) begin
          arr[shared_var] = shared_var;
          end
        shared_var++;
      end
      //$display("arr(odd)=%p",arr);
      smtx.put(1);
    join
  end
    $display("arr=%p",arr);
  end
  
endmodule