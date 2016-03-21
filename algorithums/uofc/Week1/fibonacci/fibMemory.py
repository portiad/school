count = 0
def fib(n):
  global count
  count += 1
  if n <= 1:
    return n
  return fib(n-1) + fib(n-2)

request = raw_input('Enter in a number: ')
request = int(request)
for i in range(request):
  print fib(i)

print '*********'
print count