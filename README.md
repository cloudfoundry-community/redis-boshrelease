# BOSH release for Redis

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is to deploy this bosh release.

To find available releases, learn about the jobs and packages in each release visit https://bosh.io/releases/github.com/cloudfoundry-community/redis-boshrelease

Usage
-----

To deploy a 2-node cluster:

```
bosh2 deploy manifests/redis.yml -d redis
```
