#!/usr/bin/env python3

"""
Starting in the top left corner of a 2×2 grid, and only being able to move to
the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?
"""
import time
start = time.time()

def countRoutesIterative(m,n):
    grid = [[1 for x in range(m + 1)] for x in range(n + 1)]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            grid[i][j] = grid[i - 1][j] + grid[i][j - 1]
    return grid[m][n]
print(countRoutesIterative(20,20))

def countRoutes(n):
    result = 1
    for i in range(1, n + 1):
        result *= (n + i) / i
    return result
#print(countRoutes(20))

end = time.time()
print(end - start)
