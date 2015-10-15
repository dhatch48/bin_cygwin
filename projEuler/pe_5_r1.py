#!/usr/bin/env python3

"""
2520 is the smallest number that can be divided by each of the numbers from 1
to 10 without any remainder.  

What is the smallest positive number that is evenly divisible by all of the
numbers from 1 to 20?
"""

import time
start = time.time()

def primeFac(n):
    lst = []
    c = 2
    while c <= n:
        if n % c == 0:
            n //= c
            lst.append(c)
        else:
            c += 1
    return lst

lcm = {}
for i in range(2,21):
    factors = primeFac(i)
    maxCount = {}
    #print(i,factors)
    if len(factors) == 1:
        lcm[i] = 1
    else:
        maxCount = {x: 0 for x in factors}
        for j in factors:
            maxCount[j] += 1
        for num,power in maxCount.items():
            lcm[num] = max(lcm[num],power)

product = 1
for num,power in lcm.items():
    product *= num**power
print('Answer:',product)

end = time.time()
print(end - start)
