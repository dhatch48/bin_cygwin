#!/usr/bin/env python3

"""
Starting in the top left corner of a 2×2 grid, and only being able to move to
the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?
"""
import time
start = time.time()

def latticePaths(n):
    divisor = 1
    dividend = 1
    for i in range(2, 2 * n + 1):
        divisor *= i
    for j in range(2, n + 1):
        dividend *= j
    dividend **= 2
    return divisor // dividend

print('Answer:',latticePaths(20))

end = time.time()
print(end - start)
