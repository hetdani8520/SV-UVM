# Vector Manipulation Constraint Gotchas
1. Can we use sum() method over a vector (packed arr)?
I don't think so! (sum() constraint on a vector throws compilation error on most simulator vendors). For more info ref:- https://edaplayground.com/x/MVgM

2. Solutions to all the below-mentioned problem variants can use combinations of part-select operator ([<start_idx>+:<width>]), unary/reduction operators(OR,AND, NOT etc.), XOR with $countones(to count bit flips).

## Consecutive bits of vector to constraint using SV?
1. Variant-1:- fixed start_idx & fixed width
Ex.:- Write a systemverilog constraint to generate a random 16-bit value with last 6 bits set & rest zeros. (TODO: Need to create an example for this)

2. Variant-2:- random start_idx & fixed width
Ex.:- Write a System Verilog constraint to generate a random 32-bit value with 10 contiguous bits as 0 and the remainder of the bits as 1.
Valid Output (10 contiguous 0s and remaining bits are 1): 
11111111111111111111100000000001
Invalid Output (only 9 contiguous 0s)
11111111111111111111110000000001
(ref.:- ten_consecutive_zeros_rest_ones.sv)

3. Variant-3:- random start_idx & random width
Ex:- constraint a 16 bit number such that all the 1's that it has must be consecutive. It needs to have at least one 1. 
(ref:- random_consecutive_ones_in_vec.sv)

## Random bits of a vector to be randomized/fixed?
4. Variant-4:- write a systemverilog constraint to produce a 32-bit vector with 2 bits different.
(ref:- vec_only_2_bits_change.sv)

5. Variant-5:- random width & fixed start_idx
Ex:- Write a constraint for a 32-bit variable such that the number of trailing zeros is between 5 and 10 & rest bits are one
(ref:- trailing_zeros_vec_manipulation.sv)

## Different ways(SV constraint) to generate all bits 1 for a 16-bit vector:
### ref:- all_ones_constraint.sv
1. $countones
2. manual foreach iterate over each bit
3. part-select function with unary operator combo
4. power of 2
5. left-shift 1 by N (alternative to power of 2)
6. replication operator (very important to provide size of replicated value else unsized constants are defaulted to 32-bits in a constraint)
7. signed-unsigned hack (providing size of value is important here as well => a == -(16'd1)
8. negation unary operator (a == ~(16'd0))
9. sum() method is illegal on packed arrays/vectors. (LRM:- "Array manipulation methods can be applied to unpacked arrays or queues")