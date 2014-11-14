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
    return (quanity /  len(L))**.5
    