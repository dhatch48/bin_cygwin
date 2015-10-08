#!/usr/bin/env python
""" Examples taken from: http://www.python-course.eu/recursive_functions.php """

import pdb

""" Recursive function for calculating factorials """
def factorial(n):
    print("factorial has been called with n = " + str(n))
    if n == 1:
        return 1
    else:
        res = n * factorial(n-1)
        print("intermediate result for ", n, " * factorial(" ,n-1, "): ",res)
        return res	

#pdb.run('print(factorial(4))')
print(factorial(5))


""" Iterative function for calculating factorials """
def iterative_factorial(n):
    result = 1
    for i in range(2,n+1):
        print("i: ", i, "result: ", result)
        result *= i
    return result
#print(iterative_factorial(5))
