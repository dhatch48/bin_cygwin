#!/usr/bin/env python3

""" http://databasefaq.com/index.php/answer/158935/python-recursion-prime-factoring-python-recursive-solution-for-prime-factorization-duplicate"""
import time
start = time.time()

""" Iterative way """
def primeFac(n):
    lst = []
    c = 2
    while c <= n:
        if n % c == 0:
            n //= c
            lst.append(c)
        else:
            c += 1
    return lst
#print(primeFac(600851475143))

""" Recursive way """
def primeFacRecurse(n):
    lst = []
    c = 2
    if n <= c:
        lst.append(n)
    else:
        while n % c != 0:
            if c == 2:
                c += 1
            else:
                c += 2
        if n == c:
            # Handle where n is prime
            lst.append(n)
        else:
            # Factor found now recurse on quotient
            lst.append(c)
            lst += primeFacRecurse(n // c)
        return lst
print(primeFacRecurse(600851475143))
end = time.time()
print(end - start)
