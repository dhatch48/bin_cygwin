#!/usr/bin/env python3

"""
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a**2 + b**2 = c**2

For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
"""

import time
start = time.time()
def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

# a and b are coprime when gcd == 1
def pythagoreanTripleGen(n = 1, m = 2, k = 1):
    if isinstance(n, int) and isinstance(m, int) and 0 < n < m and gcd(n, m) == 1:
        a = k * (m**2 - n**2)
        b = k * (2*m*n)
        c = k * (m**2 + n**2)
        return a, b, c
    else:
        return 0,

n, m, = 1, 2
pTripleSum = 0
while True:
    if pTripleSum == 1000:
        break
    else:
        k = 1
        pTriple = pythagoreanTripleGen(n, m, k)
        #print(pTriple)
        pTripleSum = sum(pTriple)
        while pTripleSum < 1000:
            k += 1
            pTriple = pythagoreanTripleGen(n, m, k)
            pTripleSum = sum(pTriple)
    m += 2

print(pTriple,sum(pTriple))
print('Answer:',pTriple[0]*pTriple[1]*pTriple[2])

end = time.time()
print(end - start)
