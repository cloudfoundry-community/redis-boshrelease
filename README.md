# Bosh release for redis

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is too deploy this bosh release.

## Release to your BOSH

To upload this release to your BOSH:

```
bosh target BOSH_URL
bosh login
git clone git@github.com:drnic/redis-boshrelease.git
cd redis-boshrelease
bosh upload release releases/redis-1.yml
```
