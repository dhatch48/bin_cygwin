#!/usr/bin/env python3

"""
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
"""

import time
start = time.time()

def isPrime(n):
    if n % 2 == 0:
        return False
    else:
        c = 3
        while c <= n ** 0.5:
            if n % c == 0:
                return False
            c += 2
        else:
            return True

i = 11
pSum = 17
while i < 2000000:
    if isPrime(i):
        pSum += i
    i += 2

print(pSum)

end = time.time()
print(end - start)
