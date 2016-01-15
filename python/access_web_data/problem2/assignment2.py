import re

total = 0
fileUser = input("What is the file name: ")
fileName = open(fileUser, 'r')
for line in fileName:
	line = line.rstrip()
	values = re.findall('([0-9]+)', line)
	if len(values) > 0:
		values = map(int, values)
		total += sum(values)
print(total)


"""
Bonus Question?
import re
print sum( [ ****** *** * in **********('[0-9]+',**************************.read()) ] )
"""

import re
text = "X-DSPAM-Confidence:    0.8475";
text = re.findall('([0-9]*\.[0-9]+)', text)
print(float(text[0]))