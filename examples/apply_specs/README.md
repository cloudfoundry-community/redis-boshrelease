# Example apply_spec.yml

This folder contains example specs for a bosh agent `apply` message. You could apply this to a blank bosh VM, for example one created using [bosh_agent chef cookbook](https://github.com/cloudfoundry-community/chef-bosh_agent).

The blobstore references match to an example deployment of the release and may not match to your deployment.

Edit `/var/vcap/bosh/settings.json`:

``` json
{
    "agent_id": "micro",
    "blobstore": {
        "provider": "dav",
        "options": {
            "endpoint": "http://216.55.141.200:25250",
            "user": "agent",
            "password": "agent"
        }
    },
    "disks": {
        "persistent": {}
    },
    "mbus": "https://vcap:vcap@0.0.0.0:6969",
    "networks": {},
    "ntp": []
}
```

```
$ sv restart agent
```

In a Ruby console:

``` ruby
require "agent_client"
require "yaml"

api = Bosh::Agent::Client.create("https://localhost:6969", "user" => "vcap", "password" => "vcap")
api.apply(YAML.load_file("apply_spec.yml"))
```

Watch the agent install stuff:

```
$ tail -f -n 50 /var/vcap/bosh/log/current
```