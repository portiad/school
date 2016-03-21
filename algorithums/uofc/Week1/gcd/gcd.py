count = 0
def gcd(a,b, n=0):
  global count
  count += 1
  if n == 0:
    if a > b:
      n = b
    else:
      n = a
  if a % n == 0 and b % n == 0:
    return n
  return gcd(a, b, n-1)

a = raw_input("Enter in your 1st number: ")
b = raw_input("Enter in your 2nd number: ")
a, b = int(a), int(b)

value = gcd(a, b)

print value
print count