#!/usr/bin/env python
""" Examples taken from: http://www.python-course.eu/recursive_functions.php """

import pdb
import time
start = time.time()

""" Recursive function for calculating factorials """
def factorial(n):
    if n == 1:
        return 1
    else:
        res = n * factorial(n-1)
        return res	

#pdb.run('print(factorial(4))')
print(factorial(100))


""" Iterative function for calculating factorials """
def iterative_factorial(n):
    result = 1
    for i in range(2,n+1):
        result *= i
    return result
#print(iterative_factorial(100))

end = time.time()
print(end - start)
