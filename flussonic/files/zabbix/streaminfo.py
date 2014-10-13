#!/usr/bin/python
import json
import sys
from pprint import pprint

try:
	with open('/tmp/curl_flussonic.log') as data_file:    
	    decoded_data = json.load(data_file)
	tmp = 0 
	for item in decoded_data['streams']:
		if item['name'] == sys.argv[1]:
			tmp = item[sys.argv[2]] 
	print int(tmp)
except Exception as e:
	print 0

