Change Log
==========

v8
--

Demo of manual failover of a cluster:

![cluster failover](http://cl.ly/image/332G1X242T1U/consul-manual-failover.gif)

- cluster KV only initialized once, not on each restart of monit
- redis now logging to file instead of stdout
- confd can successfully reload redis & consul (it is now running as root)
- `make_manifest` - specify name of deployment/service name with $NAME

v7
--

Progress towards Redis cluster being able to failover and dynamically reconfigure itself.

- [consul] redis.conf and consul's redis.json created by confd (from consul kv) rather than directly from BOSH

v6
--

- bug fix: Also kill redis server via pid

v5
--

- consul performs health checks: available on port, disk 50% warning and 98% critical
- correctly use /var/vcap/store/redis for persistence
- ec2 templates add a persistent disk

v4
--

- consul basic health check by writing to master node

v3
--

- supports consul to advertise service
- upgrade templates/ to look like other boshreleases

v2
--

- redis 2.8.3

v1
--

- redis 2.6.13
- single VM only
