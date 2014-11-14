# 6.00.2 Python
#
#L1 PROBLEM 3 

import string
import pylab
import numpy

SYSTEM = 'osx'
LOCATION = 'dropbox'


WORDLIST_FILENAME = "/Python/6.00.2/ps1/julytemps.txt"

if LOCATION == 'dropbox':
	WORDLIST_FILENAME = '/portia/Dropbox/dev/school' + WORDLIST_FILENAME
elif LOCATION == 'dev':
	WORDLIST_FILENAME = 'portia/dev' + WORDLIST_FILENAME

if SYSTEM == 'ubuntu':
	WORDLIST_FILENAME = "/home" + WORDLIST_FILENAME
elif SYSTEM == "osx":
	#WORDLIST_FILENAME = WORDLIST_FILENAME.lower()
	WORDLIST_FILENAME = '/Users' + WORDLIST_FILENAME

def loadFile():

	inFile = open(WORDLIST_FILENAME, 'r')

	high = []
	low = []
	for line in inFile:
	    fields = line.split()
	    if len(fields) != 3 or 'Boston' == fields[0] or 'Day' == fields[0]:
	        continue
	    else:
	        high.append(int(fields[1]))
	        low.append(int(fields[2]))
	return (low, high)

def producePlot(lowTemps, highTemps):
    diffTemps = list(numpy.array(highTemps) - numpy.array(lowTemps))
    pylab.plot(range(1,32), diffTemps)
    pylab.title('Day by Day Ranges in Temperature in Boston in July 2012')
    pylab.xlabel('Days')
    pylab.ylabel('Temperature Ranges')
    pylab.show()
    
        
(low, high) = loadFile()    
producePlot(low, high)
        
