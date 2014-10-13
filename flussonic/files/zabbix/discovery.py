#!/usr/bin/python
import json
from pprint import pprint


with open('/tmp/curl_flussonic.log') as data_file:    
    decoded_data = json.load(data_file)
tmp=[]
for item in decoded_data['streams']:
	tmp.append('{"{#STREAM_NAME}":"'+item['name']+'"}')
print '{"data":['+",".join(tmp)+']}'
