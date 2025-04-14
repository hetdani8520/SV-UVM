# UVM Scoreboard Design
1. The designer reads the specs & creates a design. The verfication engineer reads the same specs & creates a testbench to ensure design meets the requirements.
2. The goal of SCOREBOARD is to track mismatches between these two tasks
-->The testbench inputs & design outputs are captured by monitors
-->the testbench creates expected results (particularly the predictor component is responsible for that) while the design outputs are the actual results (primarily arrive from monitors)
-->In UVM, a predictor (ideally a zero-delay model) calculates the expected results (might transform input type into output), with high-level refrence model (interfacing in UVM via DPI-C)
-->The evaluator compares results, with the uvm_sequence_item::compare() method or another algorithm
-->A scoreboard contains the predictor, evaluator & storage to hold intermmediate results

# How should a scoreboard store the predicted results until needed by the evaluator?
## In-order UVM Scoreboard:
1. uvm_tlm_analysis_fifo - part of UVM base class libraries
-->Built-in put() & get() blocking methods - first-in, first out ordering (good to use when txn's are in front or back of the fifo)
2. Queues - SV dynamic arrays with built-in class methods
-->More flexible than fifo ports - can do LIFO & other ordering, and access entire array
E.g.: tx_item expected_q[$] //queue of expected tx_item txns
      expect_q.push_back(tx) //add a txn back onto a queue
      expect_q.pop_front(tx) //remove a txn off front of queue

## Out-of-order UVM Scoreboard:
1. Associative arrays - storage only created for the addresses used
-->used when DUT outputs can occur in unpredictable order
-->the scoreboard designer need to come up with a DUT seq_item field which is unique and can be used as a key quantifier for the assocative array to log DUT actual outputs when it arrives out-of-order.
E.g.: tx_item expect_a[bit [31:0]]; //associative array of tx_item txns indexed by unique key called tx.address
      expect_a[tx_address] = tx;