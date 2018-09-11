#!/bin/bash

set -u # report the usage of uninitialized variables

# Best practice per https://redis.io/topics/admin
chpst -u root:root echo never > /sys/kernel/mm/transparent_hugepage/enabled

# Fixes startup warning:
# "WARNING: The TCP backlog setting of 511 cannot be enforced because 
# /proc/sys/net/core/somaxconn is set to the lower value of 128."
#
# The maximum number of "backlogged sockets".  Default is 128.
chpst -u root:root sysctl -w net.core.somaxconn=65535

# The Linux kernel supports the following overcommit handling modes
# 0: The Linux kernel is free to overcommit memory (this is the default), 
# a heuristic algorithm is applied to figure out if enough memory is available.
# 1: The Linux kernel will always overcommit memory, and never check if enough memory is available. 
# This increases the risk of out-of-memory situations, but also improves memory-intensive workloads.
# 2: The Linux kernel will not overcommit memory, and only allocate as much memory as 
# defined in overcommit_ratio.
#
# Redis best practice is vm.overcommit_memory=1 (https://redis.io/topics/admin)
chpst -u root:root sysctl vm.overcommit_memory=1
