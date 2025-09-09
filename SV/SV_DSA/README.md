# SystemVerilog Behavioural Coding

## Arrays
1. Equilibrium index
2. Max subarray sum
3. Partition array(into smaller half and larger half based on a key)
4. Min element of array
5. Max element of array
6. Second largest element of array
7. Merge sort
8. Two sum (sorting + two pointer technique)
9. Reverse the array (decimal, binary etc.)
10. Segregate zeros (preserve order)
11. sort an array in ascending order (bubble sort)

## Strings (Basic/Easy Operations listed on GFG)
1. Anagram
2. Find longest repeating character in a string
3. https://www.geeksforgeeks.org/program-to-validate-an-ip-address/
4. reverse the string (two-pointer technique, array concatenation, streaming operator)
5. rem interview atoi & itoa questions

## Matrix
1. Matrix Multiplication
2. Transpose

## Searching Algorithms
1. Linear & Binary Search

## Recursion
1. Fibonacci
2. Factorial
3. Primes?
4. Sum of digits until one

## Misc
1. Write a function that accepts an input integer and returns the position of the first non-zero bit starting from position zero.
2. You are given a 32-bit data value data = 32'hDEADBEEF.
 Write a SystemVerilog module to extract each of the 4 bytes from this data and store them in a byte_array of type bit [7:0].
 Use a for loop and bitwise operations. Do reverse as well.
3. Given a list of signed integers (positive and negative), write a SystemVerilog function to find the number closest to zero.If two numbers are equally close (e.g., -2 and 2), prefer the positive one.
4. Fundamental Question on using Dynamic Array. Try it out for fun
Q) Create a dynamic array capable of storing 7 elements. add a value of multiple of 7 starting from 7 in the array (7, 14, 21 ....49). After 20 nsec Update the size of the dynamic array to 20. Keep existing values of the array as it is and update the rest 13 elements to a multiple of 5 starting from 5. Print Value of the dynamic array after updating all the elements.
Expected result : 7, 14, 21, 28 ..... 49, 5, 10, 15 ..... 65 .
5. Q)Write a System Verilog function to find a unique number from a given integer array, where all numbers except one appear twice. The function should use an associative array to count occurrences of each number and return the number that appears exactly once. If no unique number is found, return -1.
6. Q)Given two queues in SystemVerilog, data[$] and valid[$], where both have the same size and a one-to-one mapping, remove all elements from data[$] where the corresponding value in valid[$] is 0.
EX : 
data = {1,2,3,4,5}; 
valid = {0,1,0,1,1};