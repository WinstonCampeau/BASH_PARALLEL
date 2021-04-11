#!/bin/bash

declare -i var_0 var_1 total_runs counter thread_counter check

echo "How many runs"?

read var_0

echo ""

echo "How many processes?"

read var_1

total_runs=$(( var_0 * var_1 )) 

echo ""

echo "This operation will result in $total_runs runs. Press return key to continue."

read continue

counter=0
thread_counter=0
pids=()

while [ $counter -lt $total_runs ]
	do
	
	while [ $thread_counter -lt $var_1 ]
		do
			python3 your_program.py $counter &
			pids+=( $! )
			counter=$(($counter + 1))
			thread_counter=$(($thread_counter + 1))
		done
	
	check=0
	c_check=0
	new_array=()
	
	while [[ $check == 0 ]]
		do
			[ -d "/proc/${pids[c_check]}" ] && check=0 || check=1
			if [[ $check == 1 ]]
				then
					thread_counter=$(($thread_counter-1))
					unset pids[c_check]
					for i in ${!pids[@]};
						do
							new_array+=( ${pids[i]} )
						done
					pids=(${new_array[@]})
					unset new_array
				fi
			c_check=$(($c_check + 1))
			c_check=$(($c_check % $var_1))
		done
	done
	
pid_len=${#pids[*]}

for ((i=0; i<$pid_len; i++));
	do
		wait ${pids[i]}
	done

echo ""

echo "DONE"
