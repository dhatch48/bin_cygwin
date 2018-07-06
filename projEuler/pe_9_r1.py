#!/usr/bin/env python3

import time
start = time.time()
""" Eueler brute force method """
def a9(s = 1000):
    for a in range(3, (s-3) // 3):
        for b in range((a+1), (s-1-a) // 2):
            c = s-a-b
            if c*c == a*a + b*b:
                return a,b,c
answer = a9()
print(answer)
print(answer[0]*answer[1]*answer[2])
end = time.time()
print(end - start)
