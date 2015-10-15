#!/usr/bin/env python3

"""
http://www.programiz.com/python-programming/decorator
"""

def inc(x):
    """Function to increase value by 1"""
    return x + 1

def dec(x):
    """Function to decrease value by 1"""
    return x - 1

def operate(func, x):
    """A higer order function to increase or decrease"""
    result = func(x)
    return result

print(operate(inc,3))
print(operate(dec,3))