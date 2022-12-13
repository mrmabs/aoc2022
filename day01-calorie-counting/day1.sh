#!/bin/bash

total=0
elve=1
biggest=0
bigelf=0
#elves=()
second=0
third=0

while IFS= read -r line; do
	#echo "$line"
	if [ "$line" == "" ]; then
		echo "$elve $total"
		#elves+=("$elve" "$total")
		if (( $total > $biggest )); then
			biggest=$total
			bigelf=$elve
		elif (( $total > $second )); then
			second=$total
		elif (( $total > $third )); then
			third=$total
		fi
		total=0
		elve=$(($elve + 1))
	else
		total=$(($line + $total))
	fi
done < day1-input.txt

#echo "$elves"

echo "1: $biggest : $bigelf"
echo "2: $biggest + $second + $third $(($biggest + $second + $third))"
