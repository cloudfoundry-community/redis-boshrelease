Change Log
==========

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
