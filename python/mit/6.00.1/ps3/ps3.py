def f(x):
    import math
    return 10*math.e**(math.log(0.5)/5.27 * x)

def radiationExposure(start, stop, step):
    year = start
    exposure = 0
    while year < stop:
        exposure += f(year) * step
        year += 1
    return exposure