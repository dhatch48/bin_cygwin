#!/usr/bin/env python3

import time
start = time.time()

def is_palindrome(n):
    t = str(n)
    return t == t[::-1]

products = [x*y for x in range(999,99,-1) for y in range(999,99,-1)]
print(max(x for x in products if is_palindrome(x)))

end = time.time()
print(end - start)
