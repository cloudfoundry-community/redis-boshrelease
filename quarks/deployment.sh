#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd $ROOT

cat <<EOT
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis-manifest
data:
  manifest: |
    ---
EOT
sed 's/^/    /' < <(./quarks/merge.sh "$@")
cat <<EOT
---
apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  type: ClusterIP
  selector:
    fissile.cloudfoundry.org/instance-group-name: redis
    fissile.cloudfoundry.org/deployment-name: redis-deployment
  ports:
    - protocol: TCP
      port: 6379
      targetPort: 6379
---
apiVersion: fissile.cloudfoundry.org/v1alpha1
kind: BOSHDeployment
metadata:
  name: redis-deployment
spec:
  manifest:
    name: redis-manifest
    type: configmap
EOT