#!/usr/bin/env python3

"""
A palindromic number reads the same both ways. The largest palindrome made from
the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.
"""

import time
start = time.time()

def isPalindrome(num):
    numStr = str(num)
    if numStr == numStr[::-1]:
        return True
    else:
        return False
    
lst = []
for i in range(999,899,-1):
    for j in range(999,899,-1):
        if isPalindrome(i * j):
            lst.append(i * j)

print('Answer:',max(lst))

end = time.time()
print(end - start)
