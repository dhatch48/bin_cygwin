#!/usr/bin/env python3

"""
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that
the 6th prime is 13.

What is the 10 001st prime number?
"""

import time
start = time.time()

def isPrime(n):
    if n % 2 == 0:
        return False
    else:
        c = 3
        while c < n ** 0.5:
            if n % c == 0:
                return False
            c += 2
        else:
            return True

i = 1
count = 1
while count < 10001:
    i += 2
    if isPrime(i):
        count += 1

print(i)

end = time.time()
print(end - start)
