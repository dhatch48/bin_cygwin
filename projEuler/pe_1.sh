#!/bin/bash
sum=0
for x in {1..999}; do
    if [[ 0 = $(( $x % 3 )) || 0 = $(( $x % 5 )) ]]; then
        sum=$(( $sum + $x ))
    fi
done
echo "Answer: $sum"
