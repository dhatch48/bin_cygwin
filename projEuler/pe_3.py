#!/usr/bin/env python

import math

""" Find all prime factors then return the max"""
primeLookup = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
def isPrime(num):
    if num in primeLookup:
        return True
    else:
        numSqrt = math.sqrt(num)
        stopNumber = math.floor(numSqrt)
        #print('numSqrt: %f  stopNumber: %d' % (numSqrt,stopNumber))
        scale = []
        if stopNumber > primeLookup[-1]:
            scale = list(range(101,stopNumber+1,2))
        for i in primeLookup + scale:
            #print('i: ',i)
            if i > stopNumber:
                break
            elif num % i == 0:
                return False
        else:
            primeLookup.append(num)
            print(primeLookup)
            return True
                

primeFactors = []
def findPrimeFactors(number):
    stopNumber = math.floor(math.sqrt(number))
    #print('inputNumber: %d  stopNumber: %d' % (number,stopNumber))
    scale = []
    if stopNumber > primeLookup[-1]:
        scale = list(range(101,stopNumber+1,2))
    for i in primeLookup + scale:
        #print('current try: ',i)
        if i > stopNumber:
            # No factors found, return number
            primeFactors.append(number)
            return False

        elif number % i == 0:
            result = int(number / i)
            primeFactors.append(i)
            #print(result,primeFactors)

            if isPrime(result):
                print('got here\n')
                primeFactors.append(result)
                return True
            else:
                findPrimeFactors(result)
                break

findPrimeFactors(600851475143)
print(max(primeFactors))
#print(isPrime(31))
