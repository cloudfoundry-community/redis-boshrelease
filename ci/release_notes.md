## Improvements

When upgrading from release v12 to latest, redis fails to start because redis.log is owned by root.  This release resets ownership of /var/vcap/sys/log to vcap.