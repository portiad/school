import sys
import string
import random

FILENAME = "/Users/portia/Dropbox/dev/school/algorithms/IntegerArray.txt"

# -----------------------------------
# Helper code
# (you don't need to understand this helper code)

def main():
    file = open(FILENAME, "r")
    numArray = file.readlines()
    file.close()
    integers = []
    for num in numArray:
        try:
            integers.append(int(num))
        except Exception:
            # Couldn't parse line
            pass
    inversions, integers = SortAndCountInversions(integers)
    print "Number of pairwise inversions: ", inversions 
 
def SortAndCountInversions(array):
    length = len(array)  
    midpoint = length / 2
    inversions = 0
    if length == 1:
        return inversions, array
    else:
        leftInv, left = SortAndCountInversions(array[:midpoint])
        rightInv, right = SortAndCountInversions(array[midpoint:])
        inversions += (leftInv + rightInv)
        lenLeft = len(left)
        lenRight = len(right)
        j = k = 0
        mergedArray = []
        for i in range(0, length):
            if j != lenLeft and k != lenRight:
                if left[j] <= right[k]:
                    mergedArray.append(left[j])
                    j += 1
                else:
                    mergedArray.append(right[k])
                    k += 1
                    # Increment inversion count
                    if j != lenLeft:
                        inversions += lenLeft - j
            elif j == lenLeft:
                mergedArray.append(right[k])
                k += 1
            elif k == lenRight:
                mergedArray.append(left[j])
                j += 1
        return inversions, mergedArray       
 
if __name__ == "__main__":
    main()