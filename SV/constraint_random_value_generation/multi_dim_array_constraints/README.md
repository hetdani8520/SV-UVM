# SystemVerilog Constraint Gotchas

## sum() method to satisfy constraint on multi-dim/1-d array element types: 
1. If requirement is exactly x elements in the array should y, then you can use sum() method to satisfy that constraint.
For Ex.: lets say exactly x=4 elements should be y=5 (assuming 1d-array) (constraint exactly_5 {foreach(arr[i]){ arr[i].sum() with (int'(item == 5)) == 4;} //This ensures there are exactly 4 elements in array which have value 5.
2. For more info on 2d-array application:- ref two_x_16_constraint.sv, n_x_n_element_constraint.sv, array_1_d_constraint.sv under multi-dim_array_constraints directory
3. The above logic could also work for requirements when elements in array should be lesser than y, no more than y, or even unique for that matter...

## Unique: constraint hack to generate unique elements in a multi-dim array:(can be scaled for NxN arr)
### ref:-unique_2d_arr/unique_2d_arr_constraint.sv (for 1-5)
TODO: constraint should be scaled to make sure "all" but not only "every" rows/cols/main_diagonal/anti_diagonal is unique
IMP:Property of transitivity only applies to > or < relation but NOT to equality operations
1. only "every" row unique
2. only "every"col unique
3. only "every" main-diagonal unique
4. only "every"anti-diagonal unique
5. all elements unique

### ref:-unique_2d_arr/misc_6.sv (for 1)
1. x elements same(each with value y) & rest elements unique

### ref:-unique_2d_arr/misc_7.sv (for 1)
1. x elements same(each with value y) & remaining elements can take any value in range 

## Sorting(elements following ascending order):
### ref:-sort_2d_arr/sorting_in_2d_arr.sv (currently only row sort constraint enabled)
1. Only row sort
2. Only cols sort
3. Only main-diagonals sort
4. only anti-diagonals sort

