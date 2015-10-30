#!/usr/bin/env python3

"""
If the numbers 1 to 5 are written out in words: one, two, three, four, five,
then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in
words, how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
letters. The use of "and" when writing out numbers is in compliance with
British usage.
"""
import time
start = time.time()

# Written number length lookup
lookup = {0: 0, 1: 3, 2: 3, 3: 5, 4: 4, 5: 4, 6: 3, 7: 5, 8: 5, 9: 4, 10: 3,
        11: 6, 12: 6, 13: 8, 14: 8, 15: 7, 16: 7, 17: 9, 18: 8, 19: 8, 20: 6,
        30: 6, 40: 5, 50: 5, 60: 5, 70: 7, 80: 6, 90: 6}

total = 0
for i in range(1,1000):
    if i not in lookup:
        string = str(i)
        while len(string) > 1:
            if len(string) == 3:
                total += lookup[int(string[0])]
                total += 10 # hundred and
                string = string[1:]
            elif len(string) == 2:
                if string == '00':
                    total -= 3 # subtract and
                    break
                elif string[0] == '1':
                    total += lookup[int(string)]
                else:
                    tens = int(string[0] + '0')
                    ones = int(string[1])
                    total += lookup[tens]
                    total += lookup[ones]
                string = ''
    else:
        total += lookup[i]
total += len('onethousand')
print(total)

end = time.time()
print(end - start)
