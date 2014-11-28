#import pylab

# You may have to change this path
WORDLIST_FILENAME = "/home/portia/Dropbox/dev/school/python/6.00.2/ps2/L4P5/words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of uppercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print "Loading word list from file..."
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r', 0)
    # wordList: list of strings
    wordList = []
    for line in inFile:
        wordList.append(line.strip().lower())
    print "  ", len(wordList), "words loaded."
    return wordList

def deterVowels(wordList):
    a = 0
    e = 0
    i = 0
    o = 0
    u = 0
    c = 0
    
    for w in wordList:
        w = w.lower()
        for l in w:
            if l == 'a':
                a += 1
            elif l == 'e':
                e += 1
            elif l == 'i':
                i += 1
            elif l == 'o':
                o += 1
            elif l == 'u':
                u += 1
            else:
                c += 1
    ttl = float(a + e + i + o + u + c)
    return a/ttl, e/ttl, i/ttl, o/ttl, u/ttl, c/ttl

def plotVowelProportionHistogram(wordList, numBins=15):
    """
    Plots a histogram of the proportion of vowels in each word in wordList
    using the specified number of bins in numBins
    """
    a, e, i, o, u, c = deterVowels(wordList)
    

if __name__ == '__main__':
    wordList = loadWords()
    plotVowelProportionHistogram(wordList)
