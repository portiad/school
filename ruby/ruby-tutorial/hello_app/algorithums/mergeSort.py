import string
import random

FILENAME = "/Users/portia/Dropbox/dev/school/algorithms/IntegerArray.txt"

# -----------------------------------
# Helper code
# (you don't need to understand this helper code)
def loadFile():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print "Loading numbers list from file..."
    inFile = open(FILENAME, 'r')
    fileList = inFile.read().split()
    print "  ", len(fileList), "numbers loaded."
    return fileList

def mergeSort(items):
    if len(items) <= 1:
        return items
    mid = len(items) / 2
    left = items[:mid]
    right = items[mid:]
    left = mergeSort(left)
    right = mergeSort(right)
    l, r = 0, 0
    for i in range(len(items)):
        lval = left[l] if l < len(left) else None
        rval = right[r] if r < len(right) else None
        if (lval and rval and lval < rval) or rval is None:
            items[i] = lval
            l += 1
        elif (lval and rval and lval >= rval) or lval is None:
            items[i] = rval
            r += 1
        else:
            raise Exception('Could not merge, sub arrays sizes do not match the main array')
    return items

if __name__ == '__main__':
    # To test findBestShift:
    fileList = loadFile()
    fileList = mergeSort(fileList)

