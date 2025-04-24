# SystemVerilog Constraint Gotchas

## Multi-dimensional array constraints Hacks:
1. If requirement is exactly x elements in the array should y, then you can use sum() method to satisfy that constraint.
For Ex.: lets say exactly x=4 elements should be y=5 (assuming 1-array) (constraint exactly_5 {foreach(arr[i]){ arr[i].sum() with (int'(item == 5)) == 4;} //This ensures there are exactly 4 elements in array which have value 5.
2. For more info on 2d-array application:- ref two_x_16_constraint.sv, n_x_n_element_constraint.sv, array_1_d_constraint.sv under multi-dim_array_constraints directory
3. The above logic could also work for requirements when elements in array should be lesser than y, no more than y, or even unique for that matter...   