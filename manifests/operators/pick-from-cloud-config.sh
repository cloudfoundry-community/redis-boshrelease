#!/bin/bash

: ${BOSH_ENVIRONMENT:?required}

cloud_config=$(bosh cloud-config)
vm_type=$(bosh int <(echo "$cloud_config") --path /vm_types/0/name)
network=$(bosh int <(echo "$cloud_config") --path /networks/0/name)

>&2 echo "vm_type: ${vm_type}, network: ${network}"

cat <<YAML
- type: replace
  path: /instance_groups/name=redis/networks/name=default/name
  value: ${network}

- type: replace
  path: /instance_groups/name=redis/vm_type
  value: ${vm_type}

- type: replace
  path: /instance_groups/name=sanity-tests/networks/name=default/name
  value: ${network}

- type: replace
  path: /instance_groups/name=sanity-tests/vm_type
  value: ${vm_type}

YAML
