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

def count_inversions(to_count):
    length = len(to_count) 
    inversions = 0
    if length > 1: 
        cut = length/2
        left = to_count[0:cut] 
        right = to_count[cut:] 
        count_left, merged_left = count_inversions(left) 
        count_right, merged_right = count_inversions(right)
        count_across, merged = count_merge(merged_left, merged_right)
        inversions = count_left + count_right + count_across
    else: 
        if length == 1:
            merged = to_count 
    return inversions, merged 
    

def count_merge(left, right): 
    merged = [] 
    lenleft = len(left)
    lenright = len(right) 
    lpoint = 0
    rpoint = 0
    inversions = 0
    while lpoint<lenleft and rpoint<lenright: 
        if left[lpoint]<=right[rpoint]: 
            merged.append(left[lpoint]) 
            lpoint = lpoint + 1
        else: 
            merged.append(right[rpoint]) 
            inversions = inversions + lenleft - lpoint
            rpoint = rpoint+1 
    while lpoint<lenleft: 
        merged.append(left[lpoint])
        lpoint = lpoint + 1
    while rpoint<lenright: 
        merged.append(right[rpoint])
        rpoint = rpoint + 1
    return inversions, merged

if __name__ == '__main__':
    # To test findBestShift:
    fileList = loadFile()
    inv, fileList = count_inversions(fileList)

