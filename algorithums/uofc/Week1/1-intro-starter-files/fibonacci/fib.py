# Uses python3
import time
def calc_fib(n):
    if (n <= 1):
        return n

    return calc_fib(n - 1) + calc_fib(n - 2)

n = int(input())
start = time.time()
print(calc_fib(n))
end = time.time()
print(end - start)
