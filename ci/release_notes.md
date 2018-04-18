* Rename `redis` package to `redis-4` to communicate which major version of redis is packaged

This is to encourage people to use `bosh vendor-package redis-4 path/to/redis-boshrelease` rather than author their own `redis` packages.
