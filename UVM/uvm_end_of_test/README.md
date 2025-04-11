# End of Test Mechanisms
### How to cleanly end the test i.e. the run phase?
1. Can't wait for drivers & monitors which have forever loops which way never return
2. UVM tries to end task-based phases at the end of each time slot, unless they raise an objection
3. Common practice: raise objections in test class  & scoreboards.
4. What about dropped transactions (maybe due to a DUT bug)? Scorboard needs a timeout in this case. 

## Extend or Limit the simulation (set_drain_time/set_timeout)
### When the test drops an objection after the top sequence ends, we still need to wait for the last transactions (based on stimulus) to propagate through the design. For that matter, there are two built-in functions in UVM which can delay/limit the end of phase post objection is dropped by the test.
1. set_drain_time()-delay the end of this phase for a fixed time after the last objection is dropped (refer set_drain_time.sv for more information on its use-case) - run_phase will now end after Xns (defined by invoking set_drain_time()) post last dropped objection
2. set_timeout() - Global timeout with absolute limit (default:9200s)
2.a: only works in run_phase
2.b: must call at time 0

## Phase_ready_to_end() callback: (Extends the current phase by raising an objection)
1. UVM calls this function just before ending every task based phase
2. every class derived from uvm_component hierarcchy has a built-in virtual method called phase_ready_to_end().
3. The function is invoked  when all the objections to ending the phase & sibling phases are dropped & thus uvm_phase is ready to invoke phase_ready_to_end() now.
4. Scoreboard can implement the logic for this method based on when the expected queue status.
5. I think even if DUT has a bug & it never returns, the default global timeout (set_timeout()) should come into action & trigger to terminate the simulation gracefully & the scoreboard should return 'SCB NOT EMPTY ERROR status" signalling an actual txn did not arrive for an already expected txn sitting in a queue which would indicate/signal a DUT bug.
6. This callback code (phase_ready_to_end() impementation in scb) keeps the phase running until the scb drains. What if there is TB bug such as a race condition? - UVM calls the method a total of 20 times for every component & ends the phase thereafter.
7. Ref example implementation code:- phase_ready_to_end.sv

## TODO:Other alternatives is either watchdog timer (which would look at intf activity to decide by how much simulation/phase should be extended), uvm_heartbeat(send a signal to every component to check if it is alive)