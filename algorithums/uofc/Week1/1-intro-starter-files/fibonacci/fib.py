# Uses python3
import time
def calc_fib(n):
    if (n <= 1):
        return n
    return calc_fib(n - 1) + calc_fib(n - 2)

def iterative(n):
  seq = []
  if n <= 1:
    return n
  for i in range(n+1):
    if i <= 1:
      seq.append(i)
    else:
      seq.append(seq[i-2] + seq[i-1])
  return seq[n]



n = int(input())
if n <= 20:
  start = time.time()
  print(calc_fib(n))
  end = time.time()
  print(end - start)

start = time.time()
print(iterative(n))
end = time.time()
print(end - start)