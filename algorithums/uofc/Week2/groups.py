ages = [1, 1.5, 1.6, 2, 2.8, 3, 3.2, 4]

def Group(item):
  total = 0
  groups = []
  for i in item:
    print groups
    if total == 0 or not (i - groups[total - 1][0] <= 1):
       total += 1
       groups.append([i])
    # elif i - groups[total - 1][0] <= 1:
    else:
      groups[total - 1].append(i)
    #else:
    #  total += 1
    #  groups.append([i])
  return total, groups

print Group(ages)
