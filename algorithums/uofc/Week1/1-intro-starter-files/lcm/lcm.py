# Uses python3
import sys
import time

def eclid(a, b):
  if b == 0:
    return a
  return eclid(b, a % b)


def lcm(a, b):
  #write your code here
  if b > a:
    temp = b
    b = a
    a = temp
  gcm = eclid(a, b)
  return (a/gcm) * b

# if __name__ == '__main__':
#     input = sys.stdin.read()
#     a, b = map(int, input.split())
#     print(lcm(a, b))

var = raw_input()
a, b = map(int, var.split(" "))

start = time.time()
print lcm(a, b)
end = time.time()
print(end - start)