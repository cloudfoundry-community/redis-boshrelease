#!/bin/bash

set -u # report the usage of uninitialized variables

chpst -u root:root mkdir /var/vcap/data/redis-sentinel/config
chpst -u root:root chown -R vcap:vcap /var/vcap/data/redis-sentinel/config
