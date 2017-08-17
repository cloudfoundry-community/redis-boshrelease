# BOSH release for Redis

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is to deploy this bosh release.

* [Concourse CI](https://ci.starkandwayne.com/teams/main/pipelines/redis-boshrelease)
* Pull requests will be automatically tested against a bosh-lite (see `testflight-pr` job)
* Discussions and CI notifications at [#redis-boshrelease channel](https://cloudfoundry.slack.com/messages/C6Q802GTC/) on https://slack.cloudfoundry.org


Usage
-----

To deploy a 2-node cluster:

```
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=redis

git clone https://github.com/cloudfoundry-community/redis-boshrelease.git
cd redis-boshrelease
bosh2 deploy manifests/redis.yml
```
