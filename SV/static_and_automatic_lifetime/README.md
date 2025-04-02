# Static & Automatic Scope & Lifetime in SystemVerilog

## Scope:
1. Scope of a variable can be associated with space. Scope of a variable tells us where in the code does the variable exists.


## Lifetime:
1. Lifetime of a variable is defined as for how much time period a variable occupies a valid space in the system's memory or lifetime is the period between when memory is allocated to hold the variable and when it is freed.
2. Once the variable is out of scope its lifetime ends.

## Notes:
1. All variables & subroutines(tasks/functions with its associated input/output args & local vars) declared are defaulted to STATIC under primarily module/program block.
2. All variables & methods(tasks/functions with its associated input/output args & local vars) declared are defaulted to AUTOMATIC under classes.
3. Static variables can be referenced to by their hierarchical name (based on their scope).