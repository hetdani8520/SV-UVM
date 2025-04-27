# Strings in SystemVerilog

## String manipulation:
1. Each character in a string is stored as 8-bit (in its corresponding ASCII decoding). [A-Z = [65:90], a-z = [97:122]]
2. To reverse a string,
a. Brute-force:- one can either iterate over the string from backwards & concatenate the string in each iteration to get a resultant reversed string. ref brute_force_reverse_string.sv
b. Streaming operator: since we know each character in a string is stored as 8-bits, we can use streaming operator(pack/unpack) & reverse the input string at 8-bit slices to get the resultant string. ref streaming_op_reverse_string.sv 