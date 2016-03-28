# Uses python3
import sys
import time

def gcd(a, b):
  current_gcd = 1
  for d in range(2, min(a, b) + 1):
    if a % d == 0 and b % d == 0:
      if d > current_gcd:
        current_gcd = d
  return current_gcd

# if __name__ == "__main__":
#     input = sys.stdin.read()
#     a, b = map(int, input.split())
#     print(gcd(a, b))

def eclid(a, b):
  if b > a:
    temp = b
    b = a
    a = temp
  if b == 0:
    return a
  return eclid(b, a % b)

var = raw_input()
a, b = map(int, var.split(" "))

start = time.time()
print gcd(a, b)
end = time.time()
print(end - start)

start = time.time()
print eclid(a, b)
end = time.time()
print(end - start)