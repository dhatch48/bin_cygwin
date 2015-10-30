#!/usr/bin/env python3

"""
The following iterative sequence is defined for the set of positive integers:
    n → n/2 (n is even) n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:
    13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains
10 terms. Although it has not been proved yet (Collatz Problem), it is thought
that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
"""
import time
start = time.time()

def myCollatzSequence(n):
    seq = [n]
    while n > 1:
        if len(seq) > 500:
            return 0
        elif n % 2 == 0:
            n //= 2
        else:
            #n = (n + 1) * 2
            n = 2 * n + 2
        seq.append(n)
    return seq

i = 1000000
maxChainLength = 0
answer = 0
while i < 5000000:
    i += 1
    seq = myCollatzSequence(i)
    if len(seq) > maxChainLength:
        maxChainLength = len(seq)
        answer = i
print('lastNum:',i,'Answer:',answer,'max length:',maxChainLength)

end = time.time()
print(end - start)
