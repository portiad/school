"""
PROBLEM 1: PAYING THE MINIMUM  (10 points possible)
Write a program to calculate the credit card balance after one year if a person 
only pays the minimum monthly payment required by the credit card company each month.

The following variables contain values as described below:

balance - the outstanding balance on the credit card

annualInterestRate - annual interest rate as a decimal

monthlyPaymentRate - minimum monthly payment rate as a decimal

For each month, calculate statements on the monthly payment and remaining balance, and print to screen something of the format:

Month: 1
Minimum monthly payment: 96.0
Remaining balance: 4784.0
Be sure to print out no more than two decimal digits of accuracy - so print

Remaining balance: 813.41
instead of

Remaining balance: 813.4141998135 
Finally, print out the total amount paid that year and the remaining balance at the end of the year in the format:

Total paid: 96.0
Remaining balance: 4784.0
A summary of the required math is found below:

Monthly interest rate= (Annual interest rate) / 12.0
Minimum monthly payment = (Minimum monthly payment rate) x (Previous balance)
Monthly unpaid balance = (Previous balance) - (Minimum monthly payment)
Updated balance each month = (Monthly unpaid balance) + (Monthly interest rate x Monthly unpaid balance)

Note that the grading script looks for the order in which each value is printed out. 
We provide sample test cases below; 
we suggest you develop your code on your own machine, and make sure your code passes the sample test cases, 
before you paste it into the box below.

Test Cases to Test Your Code With. Be sure to test these on your own machine - and that you get the same output! 
- before running your code on this webpage!
Click to See Problem 1 Test Cases

The code you paste into the following box should not specify the values for the variables balance, annualInterestRate, 
or monthlyPaymentRate - our test code will define those values before testing your submission.
"""


balance = 10000
annualInterestRate = .1899
monthlyPaymentRate = .1

month = 1
totalPayment = 0

for i in range(12):
    monthlyInterestRate= annualInterestRate / 12.0
    monthlyPayment = monthlyPaymentRate * balance
    totalPayment += monthlyPayment
    balance = balance - monthlyPayment
    balance = balance + (monthlyInterestRate * balance)
    print "Month: " + str(month)
    print "Minimum monthly payment: " + str("%.2f" % monthlyPayment)
    print "Remaining balance: " + str("%.2f" % balance)
    month += 1

print "Total paid: " + str("%.2f" % totalPayment)
print "Remaining balance: " + str("%.2f" % balance)

"""
PROBLEM 2: PAYING DEBT OFF IN A YEAR  (15 points possible)
Now write a program that calculates the minimum fixed monthly payment needed 
in order pay off a credit card balance within 12 months.
By a fixed monthly payment, we mean a single number which does not change each month, 
but instead is a constant amount that will be paid each month.

In this problem, we will not be dealing with a minimum monthly payment rate.

The following variables contain values as described below:

balance - the outstanding balance on the credit card

annualInterestRate - annual interest rate as a decimal

The program should print out one line: the lowest monthly payment that will pay off all debt in under 1 year, for example:

Lowest Payment: 180 
Assume that the interest is compounded monthly according to the balance at the end of the month 
(after the payment for that month is made). The monthly payment must be a multiple of $10 and is the same for all months. 
Notice that it is possible for the balance to become negative using this payment scheme, which is okay. 
A summary of the required math is found below:

Monthly interest rate = (Annual interest rate) / 12.0
Monthly unpaid balance = (Previous balance) - (Minimum monthly payment)
Updated balance each month = (Monthly unpaid balance) + (Monthly interest rate x Monthly unpaid balance)

Test Cases to Test Your Code With. Be sure to test these on your own machine - and that you get the same output!
- before running your code on this webpage!
Click to See Problem 2 Test Cases

The code you paste into the following box should not specify the values for the variables balance or annualInterestRate 
- our test code will define those values before testing your submission.
"""


balance = 775
annualInterestRate = 0.25

monthlyInterestRate= annualInterestRate / 12.0

monthlyPayment = balance * (monthlyInterestRate / (1 -(1 + monthlyInterestRate)**-12))


if monthlyPayment % 10 >= 3.5:
    monthlyPayment = int(monthlyPayment / 10) * 10 + 10
else:
    monthlyPayment = round(monthlyPayment,-1)

print "Lowest Payment: " + str("%.0f" % monthlyPayment)

monthlyPaymentA = balance / ((1 - (1 / (1 + (annualInterestRate / 12.0))**12) ) / (annualInterestRate / 12.0))
print monthlyPaymentA