#!/usr/bin/env bash

# job template binding variables

# job name & index of this VM within cluster
# e.g. JOB_NAME=redis, JOB_INDEX=0
export NAME='<%= name %>'
export JOB_INDEX=<%= index %>
# full job name, like redis-0 or webapp-3
export JOB_FULL="$NAME-$JOB_INDEX"
export DEPLOYMENT=<%= spec.deployment %>

# % disk full levels
export DISK_CRITICAL_LEVEL=<%= p("health.disk.critical") %>
export DISK_WARNING_LEVEL=<%= p("health.disk.warning") %>

<% if_p("redis.master") do |master_host| %>
export INITIAL_ROLE=slave
export INITIAL_MASTER=<%= master_host %>
<% end.else do %>
export INITIAL_ROLE=master
export INITIAL_MASTER=''
<% end %>
