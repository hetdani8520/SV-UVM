# Fork-Join Paranoia:

## How to Kill a specific thread spawned inside fork..join?
1. Refer:- fork_join_kill_specific_thread.sv

## How do you get out of a fork (diff types)..once n number of processes have finished?
1. There are three parallel threads running in fork-join_any. I want to come-out from that when any two threads get completed.
Refer:- for fork..join_any --> fork_join_any_wait_until_2_smtx.sv & fork_join_any_wait_until_2_counter.sv
Refer:- for fork..join_none --> fork_join_none_wait_until_2_smtx.sv & fork_join_none_wait_until_2_counter.sv
For ref links:-
2. https://verificationacademy.com/forums/t/resume-simulation-when-any-2-threads-out-of-3-get-completed-within-fork-join-any/32572/6
3. 

## How to disable a random thread after coming out of fork..join_any/none?
1. Refer: process fine grain control (LRM) , disable_random_thread_after_fork.sv
2. Ref:- https://verificationacademy.com/forums/t/how-to-disable-a-random-thread-out-of-three-thread-which-are-in-fork-join-any-block-once-one-thread-is-completed/37169

## You have 4 processes-A,B,C,D. If any one of them finishes kill B. When all of them are finished print Done?
1. Refer: amazon_fork..join.sv

## Semaphore Gotcha
1. Is it possible to do a semaphore put() without get()?
Yes. According to Dave, semaphore keeps a counter of available keys. And once you get your requested keys, there is no record of who has the key or how many you took. It depends on the user as to how they manage the allocation of keys with semaphore.
For more info ref:- https://verificationacademy.com/forums/t/semaphore-put-without-get/28990


## Misc References:
1) http://sagar5258.blogspot.com/2016/02/a-process-is-built-in-class-that-allows.html
2) https://verificationacademy.com/forums/t/fork-statement-design-exit-after-any-2-out-of-3-tasks-are-completed/34255