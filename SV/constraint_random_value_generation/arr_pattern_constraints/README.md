# Pattern Constraints:
1. Hack:1 - use of modulo operator (%N) which restricts the value between 0 to N-1 & which can often be used as terminator from where a pattern starts repeating itself. %N is often used on index of the array.
2. Hack:2 - use of division operator (/M) which gives you quotient. That is also useful if numbers in a pattern repeats (Ex.:000111222...) at regular intervals.

## Problems-1:
1. Write a SV constraint to generate the pattern 1234554321.
2. Write a SV constraint to generate the pattern 123123123123.
3. Write a SV constraint to generate the pattern 100100100100.
4. Pattern 1221221221221…. (same as q3) https://edaplayground.com/x/DNQW
5. Write a constraint to generate the pattern 0102030405
6. Write a constraint to generate the pattern 1122334455 (use i%2  as %2 will constrain index b/w 0 – N-1(1))
7. Write a constraint to generate the pattern 5 -10 15 -20 25 -30.
8. Write a constraint to generate the pattern 9 19 29 39 49 59 69 79.
9. Write a constraint to generate the pattern 1234554321.
10. Write a constraint to generate the pattern 0101010101.

11. Multiple combinations of 1's and 0's
11.1. 101010101010 ....
11.2. 110011001100 ...
11.3. 111000111000.

....

12. Multiple combinations of 0's and 1's
12.1.01010101 ....
12.1.001100110011 ....
12.2. 000111000111 ...

13. Pattern of integers in repeated fashion
13.1. 000000000000 ....
13.2. 012345678910 ....
13.3. 001122334455 ....
13.4. 000111222333 ....

14. Pattern of integers in an incremental fashion where every 3rd position is
incrementing
14.1.001002003004
....

15. Pattern to generate multiple of 10, starting from '0'.
15.1.0102030405060 ....

16. Pattern to generate
16.1.010011000111

17. Pattern for 10 ones in an array with no side-by-side ones. Avoid calling of
'$countones' system task
17.1. 10100010010101010100000010001000 (An example)
