x = [0, 10, 26, 100, 160, 260, 350, 500, 625, 800, 1025, 1400, 1700, 2000]

currentRefill = 0
numRefills = 0
stations = []
L = 400
n = 2000
success = True

while x[currentRefill] < n:
  lastRefill = currentRefill

  while (x[currentRefill] < n and x[currentRefill + 1] - x[lastRefill] <= L):
    currentRefill += 1
  if currentRefill == lastRefill:
    print "You're Fucked"
    success = False
    break
  if x[currentRefill] < n:
    numRefills += 1
    stations.append(x[currentRefill])
  print stations

if success:
  print 'Refills', numRefills
  print 'Stations', stations