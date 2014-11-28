def seqlist(first,c,l):
    if l == 0:
        return [first]
    return [first] + seqlist(first + c, c, l-1)
    
def sumDigits(number):
    number = abs(number)
    if not number:
        return number
    return number%10 + sumDigits(number/10)

def truthy(): print("True")
def falsey(): print("False")           
    
def _if(bool, func1, func2):
  # ... your code here!
    if bool:
        return func1()
    return func2()