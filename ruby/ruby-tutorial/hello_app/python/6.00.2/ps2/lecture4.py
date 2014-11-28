def stdDevOfLengths(L):
    if len(L) == 0:
        return 'NaN'
    totLength = 0.0
    quanity = 0.0
    for l in L:
        totLength += len(l)
    mean = float(totLength / len(L))
    for l in L:
        quanity += (len(l) - mean)**2
    return (quanity /  len(L))**.5, mean

def stdDev(L):
    mean = float(sum(L) / len(L))
    quanity = 0.0
    
    for n in L:
        quanity += (n - mean)**2
    return (quanity / len(L))**.5, mean
            
    
def coeffVar(L):
    stDev, mean =  stdDev(L)
    
    return stDev/mean