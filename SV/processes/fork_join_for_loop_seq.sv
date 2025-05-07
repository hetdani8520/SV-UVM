// Interview Question
// Fill in the code below

//credits for the problem statement:- https://www.youtube.com/watch?v=lN7fqqa9BqQ&list=PLScWdLzHpkAcNa1vjkzPY7L1YiLbH0p44&index=7&t=2s

class my_sequencer;
  int id;
endclass : my_sequencer

class my_sequence;
  task start (my_sequencer seqr);
    int delay = $urandom_range(1,10);
    $display("time: %d, starting sequence on sequencer with id:%d", $time, seqr.id);
    #(delay * 1us);
    $display("time: %d, finishing sequence on sequencer with id:%d", $time, seqr.id);
  endtask : start
endclass : my_sequence


module top;
  initial begin
    my_sequencer seqr;
    my_sequencer seqr_q[$];
    static int num_of_seqr = $urandom_range(3,5);
    
    for (int i = 0; i < num_of_seqr; i++) begin
      seqr = new;
      seqr.id = i;
      seqr_q.push_back(seqr);
    end
   
        // write SV code to start a new instance of my_sequence on each of the sequencers in seqr_q
    // conditions:
    // 1) all sequences must start simultaneously (at time 0)
    // 2) code must wait until all sequences are finished before reaching "end" of initial block
    
    /*********************************************************/
    for(int j=0;j<seqr_q.size();j++)
     begin:for_loop     
        fork
          automatic int k = j;
          begin:thread_here
           my_sequence seq =new();
           seq.start(seqr_q[k]);
          end:thread_here
        join_none
     end:for_loop
     wait fork;
    /******************************************************/
  

    $display("time: %d, end reached", $time);
  end
endmodule