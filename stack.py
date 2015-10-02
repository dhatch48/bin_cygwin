#!/bin/python

stack = []
stack.append(1)
stack.append(2)
stack.append(3)
print(stack)

stackSum = sum(stack)
var1 = stack.pop()
print(stackSum,var1,stack)
