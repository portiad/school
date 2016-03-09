import urllib
import xml.etree.ElementTree as ET

while True:
    url = raw_input('Enter url: ')
    if len(url) < 1 : url = 'http://python-data.dr-chuck.net/comments_42.xml'

    print 'Retrieving', url
    uh = urllib.urlopen(url)
    data = uh.read()
    print 'Retrieved',len(data),'characters'
    print data
    tree = ET.fromstring(data)


    results = tree.findall('.//count')
    
    count = 0
    value = 0
    for result in results:
        count += 1
        value += int(result.text)

    print 'Count:',count
    print 'Sum:',value