#!/usr/bin/env python3

"""
215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 21000?
"""
import time
start = time.time()

n = str(2 ** 1000)
nSum = 0
for i in n:
    nSum += int(i)
print('Answer:',nSum)

end = time.time()
print(end - start)
