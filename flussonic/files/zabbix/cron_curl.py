#!/usr/bin/python
import urllib2
import json
from pprint import pprint

u='{{ user }}'
p='{{ passwd }}'
url='http://{{url}}/flussonic/api/streams'

# simple wrapper function to encode the username & pass
def encodeUserData(user, password):
    return "Basic " + (user + ":" + password).encode("base64").rstrip()

# create the request object and set some headers
req = urllib2.Request(url)
req.add_header('Accept', 'application/json')
req.add_header("Content-type", "application/x-www-form-urlencoded")
req.add_header('Authorization', encodeUserData(u, p))
# make the request and print the results
res = urllib2.urlopen(req)
results =''.join(res.read().splitlines())
print results
