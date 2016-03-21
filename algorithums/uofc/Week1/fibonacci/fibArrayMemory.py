count = 0
fib = []

def fibArray(n):
  global fib
  for i in range(n):
    if i <= 1:
      fib.append(i)
    else:
      fib.append(fib[i-1] + fib[i-2])
  return fib

request = raw_input('Enter in a number: ')
request = int(request)

fibArray(request)