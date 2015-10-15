#!/usr/bin/env python3

"""
If a function contains at least one yield statement (it may contain other yield or return statements), it becomes a generator function.
Both yield and return will return some value from a function. The difference is that, while a return statement terminates a function entirely,
yield statement pauses the function saving all its states and later continues from there on successive calls.
"""

def my_gen():
    """a simple generator function"""
    n = 1
    print("This is printed first")
    # Generator function contains yield statements
    yield n

    n += 1
    print("This is printed second")
    yield n

    n += 1
    print("This is printed at last")
    yield n

a = my_gen()

print(next(a))
print(next(a))
print(next(a))

"""
http://www.programiz.com/python-programming/generator
A for loop takes an iterator and iterates over it using next() function.
It automatically ends when StopIteration is raised.
"""
for item in my_gen():
	print(item)
print('\n')
	
def PowTwoGen(max = 0):
    n = 0
    while n < max:
        yield 2 ** n
        n += 1

a = PowTwoGen(5)
for item in a:
	print(item)

def all_even():
    n = 0
    while True:
        yield n
        n += 2

print('\n')
a = all_even()
print(next(a))
print(next(a))
print(next(a))
print(next(a))
print(next(a))
print(next(a))
print(next(a))