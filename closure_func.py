#!/usr/bin/env python3

"""
http://www.programiz.com/python-programming/closure
Here is a simple example where a closure might be more preferable than defining a class and making objects. But the preference is all yours.
"""
def make_multiplier_of(n):
    def multiplier(x):
        return x * n
    return multiplier


times3 = make_multiplier_of(3)
times5 = make_multiplier_of(5)

print(times3(9))
print(times5(3))
print(times5(times3(2)))
