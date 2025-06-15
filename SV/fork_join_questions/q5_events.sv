module q5_events;
  event eva_c, ev_b;
  
  initial begin    
    fork
     begin:A_C
        $display("Process_A completed");
        $display("Process_C completed");
        ->eva_c;
      end
      
      begin:B
        $display("Process_B completed");
        ->ev_b;
      end
      
      begin:D
        wait(eva_c.triggered && ev_b.triggered); //wait until ac & b are completed
        $display("Process_D completed");
      end
    join
  end
  
endmodule