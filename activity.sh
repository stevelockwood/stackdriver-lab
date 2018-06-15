#!/bin/bash

# get projectid
# get sql instance ip
# get load balancer ip
# get apache ip

# generate apache 200s
nohup watch curl http://apacheip &

# generate apache 404s
nohup watch curl http://apacheip/missing.html &

# generate apache 403s
nohup watch curl http://apacheip/secured.html &

# generate nginx 200s
watch curl http://apacheip

# generate nginx 404s
watch curl http://apacheip/missing.html

# generate nginx 403s
watch curl http://apacheip/secured.html

# generate sql permission denied
# generate sql bad db

# generate pubsub activity
