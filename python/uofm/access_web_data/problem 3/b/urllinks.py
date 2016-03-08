# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib
from BeautifulSoup import *

url = raw_input('Enter URL: ')
count = int(raw_input('Enter count: '))
position = int(raw_input('Enter position: '))


while count >= 0:
  print url
  html = urllib.urlopen(url).read()
  soup = BeautifulSoup(html)
  tags = soup('a')
  tag = tags[position - 1]
  url = tag.get('href', None)
  count -= 1