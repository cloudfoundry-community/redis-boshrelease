# BOSH release for Redis

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is to deploy this bosh release. It can also be deployed to Kubernetes using Quarks/`cf-operator` and a Helm chart.

* [Concourse CI](https://ci-ohio.starkandwayne.com/teams/cfcommunity/pipelines/redis-boshrelease)
* Pull requests will be automatically tested against a bosh-lite (see `testflight-pr` job)
* Discussions and CI notifications at [#redis-boshrelease channel](https://cloudfoundry.slack.com/messages/C6Q802GTC/) on https://slack.cloudfoundry.org

Deploy Redis cluster with pre-compiled releases to a BOSH director:

```plain
bosh -d redis deploy \
    <(curl -L https://raw.githubusercontent.com/cloudfoundry-community/redis-boshrelease/master/manifests/redis.yml)
```

Deploy Redis cluster with pre-compiled Docker images to Kubernetes that is running Quarks (`cf-operator`) in the same namespace:

```plain
helm repo add starkandwayne https://helm.starkandwayne.com
helm repo update
helm upgrade --install --wait --namespace scf \
    redis-deployment \
    starkandwayne/redis
```

## BOSH usage

This repository includes base manifests and operator files. They can be used for initial deployments and subsequently used for updating your deployments.

To deploy a 2-node cluster:

```plain
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=redis

git clone https://github.com/cloudfoundry-community/redis-boshrelease.git
bosh deploy redis-boshrelease/manifests/redis.yml
```

If your BOSH does not have Credhub/Config Server, then remember `--vars-store` to allow generation of passwords and certificates.

```plain
bosh deploy redis-boshrelease/manifests/redis.yml --vars-store creds.yml
```

If you have any errors about `Instance group 'redis' references an unknown vm type 'default'` or similar, there is a helper script to select a `vm_type` and `network` from your Cloud Config:

```plain
bosh deploy redis-boshrelease/manifests/redis.yml -o <(./manifests/operators/pick-from-cloud-config.sh)
```

### Sentinel

**This is not a cluster_enabled redis deployment.**

Redis Sentinel provides high availability for Redis. In this bosh release, you can include the redis-sentinel job to manage failover for 2 or more Redis instances in replication mode.

**Note: Set "bind_static_ip" to true using the redis-sentinel job.**

```plain
[...]
  instances: 3
  jobs:
[...]
  - name: redis
    release: redis
  - name: redis-sentinel
    release: redis
  properties:
    bind_static_ip: true
    password: ((redis_password)
```

### Update

When new versions of `redis-boshrelease` are released the `manifests/redis.yml` file will be updated. This means you can easily `git pull` and `bosh deploy` to upgrade.

```plain
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=redis
cd redis-boshrelease
git pull
cd -
bosh deploy redis-boshrelease/manifests/redis.yml
```

### Development

To create/upload/deploy local changes to this BOSH release use the `create.yml` operator:

```plain
bosh -d redis deploy manifests/redis.yml -o manifests/operators/create.yml
```
