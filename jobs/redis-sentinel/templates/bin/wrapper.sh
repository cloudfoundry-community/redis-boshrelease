#!/bin/bash

set -u # report the usage of uninitialized variables

conf_file=$1
dest_conf=/var/vcap/data/redis-sentinel/config/sentinel.conf
cp $conf_file $dest_conf

exec /var/vcap/packages/redis-4/bin/redis-server $dest_conf --sentinel 
