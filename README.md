# Bosh release for redis [![Build Status](https://travis-ci.org/cloudfoundry-community/redis-boshrelease.png?branch=master)](https://travis-ci.org/cloudfoundry-community/redis-boshrelease/)

One of the fastest ways to get [redis](http://redis.io) running on any infrastructure is to deploy this bosh release.

## Usage

To use this bosh release, first upload it to your bosh:

```
bosh target BOSH_URL
bosh login
git clone git@github.com:cloudfoundry-community/redis-boshrelease.git
cd redis-boshrelease
bosh upload release releases/redis-1.yml
```

Now create a deployment file and deploy:

```
bosh deployment path/to/deployment.yml
bosh deploy
```

If you deploy more than one instance in a job it assumes that you want replication, and you need to specify the IP address of the master node in your deployment manifest.

### Create deployment file from templates

There are helpful base templates for AWS, OpenStack, and Warden (bosh-lite) CPIs.

See the `examples/try_me.yml` file for complete inline documentation.

For example, to deploy to bosh-lite (warden), modify `examples/try_me.yml` to look like:

```
---
name: redis
director_uuid: CHANGEME
networks: {}
properties:
  redis: {}
```

The `properties.redis` examples in `try_me.yml` aren't required for Warden.

Now:

```
bosh deployment examples/try_me.yml
bosh diff templates/warden/single_vm.yml.erb
bosh deploy
```

To access the running Redis server, that is now running within a warden container within Vagrant, you must ssh into Vagrant:

```
vagrant ssh
$ redis-cli -h 10.244.1.2 -a p@ssw0rd
```

## Development


## Create new final release

To create a new final release you need to get read/write API credentials to the [@cloudfoundry-community](https://github.com/cloudfoundry-community) s3 account.

Please email [Dr Nic Williams](mailto:&#x64;&#x72;&#x6E;&#x69;&#x63;&#x77;&#x69;&#x6C;&#x6C;&#x69;&#x61;&#x6D;&#x73;&#x40;&#x67;&#x6D;&#x61;&#x69;&#x6C;&#x2E;&#x63;&#x6F;&#x6D;) and he will create unique API credentials for you.

Create a `config/private.yml` file with the following contents:

``` yaml
---
blobstore:
  s3:
    access_key_id:     ACCESS
    secret_access_key: PRIVATE
```

You can now create final releases for everyone to enjoy!

```
bosh create release
# test this dev release
git commit -m "updated redis"
bosh create release --final
git commit -m "creating vXYZ release"
git tag vXYZ
git push origin master --tags
```

