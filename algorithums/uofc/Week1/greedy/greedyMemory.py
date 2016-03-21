x = [0, 2, 10, 300, 450, 600, 800, 1200, 1800]

totalRefills = 0
stations = []
currentRefill = 0
n = max(x)
L = 400
success = True

while x[currentRefill] < n:
  lastRefill = currentRefill
  while x[currentRefill] < n and (x[currentRefill + 1] - x[lastRefill]<= L):
    currentRefill += 1
  if currentRefill == lastRefill and x[currentRefill] != n:
    print "You fucked"
    success = False
    break
  if x[currentRefill] < n:
    totalRefills += 1
    stations.append(x[currentRefill])

if success:
  print stations
  print totalRefills
