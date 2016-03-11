import json
import urllib

input = raw_input('Url:')
if len(input) < 1 : input = "http://python-data.dr-chuck.net/comments_42.json"

connection = urllib.urlopen(input)
data = connection.read()

info = json.loads(data)
#print json.dumps(info, indent=2 )
print 'User count:', len(info['comments'])

value = 0
count = 0

for item in info['comments']:
  value += item['count']
  count += 1

print 'Sum', value
print 'Count', count