def gcdEclid(a,b):
  if b > a:
    temp = b
    b = a
    a = temp
  if b == 0:
    return a
  print a, a % b
  return gcdEclid(b, a % b)

a = raw_input("Enter in your 1st number: ")
b = raw_input("Enter in your 2nd number: ")
a, b = int(a), int(b)

start = time.time()
print gcdEclid(a, b)
end = time.time()
print(end - start)