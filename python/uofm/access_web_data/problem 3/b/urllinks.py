# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib
from BeautifulSoup import *

url = raw_input('Enter URL: ')
count = raw_input('Enter count: ')
position = raw_input('Enter position: ')
html = urllib.urlopen(url).read()
soup = BeautifulSoup(html)

# Retrieve all of the anchor tags
tags = soup('a')
print tags

currentCount = 0
currentPosition = 1

for tag in tags:
  if currentCount == int(count):
    break
  elif currentPosition % int(position) == 0:
    print tag.get('href', None)
    currentCount += 1
  currentPosition += 1