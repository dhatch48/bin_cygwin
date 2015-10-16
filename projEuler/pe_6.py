#!/usr/bin/env python3

"""
The sum of the squares of the first ten natural numbers is,
12 + 22 + ... + 102 = 385

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... + 10)2 = 552 = 3025

Hence the difference between the sum of the squares of the first ten natural
numbers and the square of the sum is 3025 − 385 = 2640.

Find the difference between the sum of the squares of the first one hundred
natural numbers and the square of the sum.
"""

import time
start = time.time()

sum1,sum2 = 0,0
for i in range(1,101):
    sum1 += i ** 2
    sum2 += i
print('Answer:',sum2**2 - sum1)

end = time.time()
print(end - start)

# Or one lineer
print(sum(range(1,101))**2 - sum([x**2 for x in range(1,101)]))
