#!/usr/bin/env python3

"""
2520 is the smallest number that can be divided by each of the numbers from 1
to 10 without any remainder.  

What is the smallest positive number that is evenly divisible by all of the
numbers from 1 to 20?
"""

import time
start = time.time()

primes = [2,3,5,7,11,13,17,19]
startNum = 1
for i in primes:
    startNum *= i
print('startNum:',startNum)

while True:
    for i in range(3,21):
        if startNum % i != 0:
            startNum += 10
            break
    else:
        print('Answer:',startNum)
        break

end = time.time()
print(end - start)
