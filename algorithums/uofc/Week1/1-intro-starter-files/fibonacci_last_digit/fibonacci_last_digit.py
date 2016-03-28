# Uses python3
import sys

def get_fibonacci_last_digit(n):
    # write your code here
    return 0

# if __name__ == '__main__':
#     input = sys.stdin.read()
#     n = int(input)
#     print(get_fibonacci_last_digit(n))


def fibLast(n):
  seq = []
  if n <= 1:
    return n
  for i in range(n+1):
    if i <= 1:
      seq.append(i)
    else:
      seq.append((seq[i-2] + seq[i-1]) % 10)
  return seq[n]

var = input()
print figBig(var)