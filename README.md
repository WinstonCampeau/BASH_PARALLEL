# BASH_PARALLEL
A small bash script for running serial jobs of variable time in parallel. 

I wrote this script to parallelize serial python jobs on Ubuntu 18.04.5 LTS. Once a process is complete, a new process is immediately fed in. It does so by keeping track of the process ids (pids); nothing more, nothing less. 

First you need to edit line 32 to your needs. By default it is:

`python3 your_program.py $counter &`

Thus, the script is set by default to run a python3 script, and will send $counter to the script to differentiate your outputs. For example, say you want 32 processes running in parallel, $counter will send (0, 1, ... , 31) to each of the individual processes. Now, say your program outputs csv files, then you could label each csv as "run0", "run1", ... "run31". To use $counter in ptyhon you would do something like:

```
# test_script.py

import sys

output_name = "run" + str(sys.argv[1])

print(output_name)

```

Where, sys.argv[1] == $counter.

Otherwise, all you need to know are how the script prompts work. First you will be asked how many runs, and then how many processes. How many processes means how many threads of your CPU you would like to use. For example, I originally wrote this script to run on a Ryzen 7 3800X which has 16 threads available. So, if I wanted to utilize all the threads available on that CPU I would enter "16". How many runs is how many times you want that process to repeat. So, if you wanted a total of 32 processes on a Ryzen 3800X, you could select 2 runs and 16 processes.

Say we replaced "test_script.py" with "your_program.py". Then in terminal we ran,

'bash bash_parallel.sh'

and answered the prompt as follows,

```
How many runs?
2

How many processes?
4

This operation will result in 8 runs. Press return key to continue.
```

Then the output would be (order may change):

```
run0
run1
run2
run3
run4
run5
run6
run7
```

And that's it!
