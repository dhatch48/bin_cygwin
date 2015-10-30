#!/usr/bin/env python

""" Examples taken from: http://www.python-course.eu/recursive_functions.php """

""" Inefficient Recursive function for calculating fibonacci numbers """
def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-1) + fib(n-2)

""" Iterative function for calculating fibonacci numbers """
def fibi(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a

""" Efficient recursive function for calculating fibonacci numbers with memory
to avoid duplicate calculations
"""
memo = {0:0, 1:1}
def fibm(n):
    if not n in memo:
        memo[n] = fibm(n-1) + fibm(n-2)
    return memo[n]

print(fib(7))
print(fibi(7))
print(fibm(7))
