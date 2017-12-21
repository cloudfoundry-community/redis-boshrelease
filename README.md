# BOSH release for Redis

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is to deploy this bosh release.

* [Concourse CI](https://ci-ohio.starkandwayne.com/teams/cfcommunity/pipelines/redis-boshrelease)
* Pull requests will be automatically tested against a bosh-lite (see `testflight-pr` job)
* Discussions and CI notifications at [#redis-boshrelease channel](https://cloudfoundry.slack.com/messages/C6Q802GTC/) on https://slack.cloudfoundry.org


Usage
-----

This repository includes base manifests and operator files. They can be used for initial deployments and subsequently used for updating your deployments.

To deploy a 2-node cluster:

```
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=redis

git clone https://github.com/cloudfoundry-community/redis-boshrelease.git
bosh deploy redis-boshrelease/manifests/redis.yml
```

If your BOSH does not have Credhub/Config Server, then remember `--vars-store` to allow generation of passwords and certificates.

```
bosh deploy redis-boshrelease/manifests/redis.yml --vars-store creds.yml
```

If you have any errors about `Instance group 'redis' references an unknown vm type 'default'` or similar, there is a helper script to select a `vm_type` and `network` from your Cloud Config:

```
bosh deploy redis-boshrelease/manifests/redis.yml -o <(./manifests/operators/pick-from-cloud-config.sh)
```

### Update

When new versions of `redis-boshrelease` are released the `manifests/redis.yml` file will be updated. This means you can easily `git pull` and `bosh deploy` to upgrade.

```
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=redis
cd redis-boshrelease
git pull
cd -
bosh deploy redis-boshrelease/manifests/redis.yml
```
