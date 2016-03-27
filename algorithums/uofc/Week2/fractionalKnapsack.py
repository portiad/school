ITEMS = [
  ('A', 10, 5),
  ('B', 9, 3),
  ('C', 2, 2),
  ('D', 21, 7)
]

def efficiency(item):
  return item[1]/item[2]

def knapSack(W, items):
  knap = []
  value = 0
  totalWeight = 0
  temp = items
  while totalWeight < W:
    highest = None
    for i in temp:
      if highest == None:
        highest = i
      elif efficiency(i) > efficiency(highest):
        highest = i
    if totalWeight + highest[2] <= W:
      knap.append(highest)
      totalWeight += highest[2]
      value += highest[1]
      temp.remove(highest)
    else:
      required = W - totalWeight
      knap.append([highest[0], required * efficiency(highest), required])
      totalWeight += required
      value += required * efficiency(highest)
  return knap, value, totalWeight

print knapSack(5, ITEMS)