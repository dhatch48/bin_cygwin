#!/usr/bin/env python

myList = [1,2]
evenFibList = [2]
while myList[1] < 4000000:
    myList[0] = sum(myList)
    if myList[0] % 2 == 0:
        evenFibList.append(myList[0])
    myList.sort()

print(myList,evenFibList)
answer = sum(evenFibList)
print("Answer: %d" % answer)
