# Fork-join Interview Questions:
1. Basic code to mimic fork-join behaviour
1.a. fork-join
1.b fork-join_any
1.c fork-join_none
2. wait for x parallel threads using semaphore before progressing ahead in the code..
3. Kill/disable y threads after x(any one usually) threads finish execution
3a:- y = all
3b:- y = any one random (from still active threads)
4. Misc q1:- //A,B,C,D threads
//B should start after A
//D should start after B & C
5. Misc q2:- Write code that will create the four processes (Process_A through Process_D). Process_C should begin when Process_A has finished, and then Process_D. However, Process_D ought to wait for Process_B to finish. 
6. Misc q3: Write a multi-threaded code with one thread printing all even numbers and the other all odd numbers. The output should always be in sequence Eg :  0,1,2,3,4… etc