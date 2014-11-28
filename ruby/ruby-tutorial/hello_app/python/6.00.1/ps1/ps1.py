"""
COUNTING VOWELS  (10 points possible)
Assume s is a string of lower case characters.

Write a program that counts up the number of vowels contained in the string s. Valid vowels are: 'a', 'e', 'i', 'o', and 'u'. 
For example, if s = 'azcbobobegghakl', your program should print:

Number of vowels: 5
For problems such as these, do not include raw_input statements or define the variable s in any way. 
Our automated testing will provide a value of s for you - 
so the code you submit in the following box should assume s is already defined. 
If you are confused by this instruction, please review L4 Problems 10 and 11 before you begin this problem set.
"""

s = raw_input("Enter in a string")
s = s.lower()
counter = s.count('a') + s.count('e') + s.count('i') + s.count('o') + s.count('u')
print "Number of vowels: " + str(counter)

"""
COUNTING BOBS  (15/15 points)
Assume s is a string of lower case characters.

Write a program that prints the number of times the string 'bob' occurs in s. 
For example, if s = 'azcbobobegghakl', then your program should print

Number of times bob occurs is: 2
For problems such as these, do not include raw_input statements or define the variable s in any way. 
Our automated testing will provide a value of s for you - 
so the code you submit in the following box should assume s is already defined. 
If you are confused by this instruction, please review L4 Problems 10 and 11 before you begin this problem set.
"""

s = raw_input("Input a string with a number of bob's")

s = s.lower()
bob = 0
for i, _ in enumerate(s):
    if s[i:i+3] == 'bob':
        bob += 1
print "Number of times bob occurs is: " + str(bob)


"""
ALPHABETICAL SUBSTRINGS  (15 points possible)
Assume s is a string of lower case characters.

Write a program that prints the longest substring of s in which the letters occur in alphabetical order. 
For example, if s = 'azcbobobegghakl', then your program should print

Longest substring in alphabetical order is: beggh
In the case of ties, print the first substring. For example, if s = 'abcbcd', then your program should print

Longest substring in alphabetical order is: abc
For problems such as these, do not include raw_input statements or define the variable s in any way. 
Our automated testing will provide a value of s for you - 
so the code you submit in the following box should assume s is already defined. 
If you are confused by this instruction, please review L4 Problems 10 and 11 before you begin this problem set.

Note: This problem is fairly challenging. We encourage you to work smart. 
If you've spent more than a few hours on this problem, we suggest that you move on to a different part of the course. 
If you have time, come back to this problem after you've had a break and cleared your head.
"""
#pos = 0
#start = 0
#end = 0

maxLen = 0

def last(pos):
    if pos < (len(s) - 1):
        if s[pos + 1] >= s[pos]:
            pos += 1
            if pos == len(s)-1:
                #print "l:" + str(len(s))
                return len(s)
            else:
                #print "lp:" + str(last(pos))
                return last(pos)
        #print "p" + str(pos)
        return pos   

#s = 'jpueyzahlz'

for i in range(len(s)):
    if last(i) != None:
        if last(i) == len(s):
            diff = last(i) - i
        else:
            diff = last(i) - i + 1
        #print "d:" + str(diff) + " l:" + str(last(i)) + " i:" + str(i)
    if diff > maxLen:
        maxLen = diff
        start = i
        end = start + diff - 1
        #print "s:" + str(start) + " e:" + str(end)
        #print

print "Longest substring in alphabetical order is: " + s[start:end+1]