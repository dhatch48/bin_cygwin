#!/usr/bin/env python3

import time
start = time.time()

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

""" Eueler scalable solution """
def a9(s = 1000):
    s2 = s // 2
    mlimit = int(s2 ** 0.5) - 1
    for m in range(2, mlimit):
        if s2 % m == 0:
            sm = s2 / m
            while sm % 2 == 0: # reduce the search space by
                sm = sm / 2 # removing all factors 2
            if m % 2 == 1:
                k = m + 2 
            else:
                k = m + 1
            while k < 2 * m and k <= sm:
                if sm % k == 0 and gcd(k,m) == 1:
                    d = s2 // (k*m)
                    n = k - m
                    a = d * (m * m - n * n)
                    b = 2 * d * m * n
                    c = d * (m * m + n * n)
                    return(a, b, c)
                k += 2

answer = a9(1000)
print(answer)
print(answer[0]*answer[1]*answer[2])
end = time.time()
print(end - start)
