# WIP experiments for deploying to Kubernetes with Quarks

Commands are run from root of project.

To watch the various resources come to life:

```plain
watch -n1 "kubectl get svc,pod,statefulset,bdpl,ests,esec,ejob,pv,pvc -n kubecf"
```

To access Redis service from local machine, use `kwt`:

```plain
sudo -E kwt net start --namespace kubecf
```

In another terminal, discover the hostname for the service and access via `redis-cli`:

```plain
$ kwt net svc -n kubecf
Services in namespace 'kubecf'

Name                      Internal DNS                                    Cluster IP    Ports
cf-operator-webhook       cf-operator-webhook.kubecf.svc.cluster.local       10.20.10.25   443/tcp
redis-deployment          redis-deployment.kubecf.svc.cluster.local          10.20.14.166  6379/tcp
redis-deployment-redis    redis-deployment-redis.kubecf.svc.cluster.local    None          6379/tcp
redis-deployment-redis-0  redis-deployment-redis-0.kubecf.svc.cluster.local  10.20.13.16   6379/tcp

$ redis_password="$(k get secret -n kubecf redis-deployment.var-redis-password --template '{{.data.password}}' | base64 --decode)"
$ redis-cli -h redis-deployment.kubecf.svc.cluster.local -a "${redis_password}"
redis-deployment.kubecf.svc.cluster.local:6379> set hello world
OK
redis-deployment.kubecf.svc.cluster.local:6379> get hello
"world"
```

## Original redis.yml and operators

```plain
kubectl apply -n kubecf -f quarks/deployment.yml
```

## Fail fast with Generated Quarks manifest

Fast failure of BOSH operators by running them thru `bosh int` immediately, rather than within `cf-operator`:

```plain
kubectl apply -n kubecf \
    -f <(./quarks/deployment.sh \
           quarks/operations/gke/gke-persistence.yml \
            quarks/operations/optional/solo.yml)
```

## Helm chart

The `quarks/helm/redis` folder contains a Helm chart. It includes symlinks to assets in other folders, including the BOSH manifest `manifests/redis.yml`.

```plain
helm upgrade --install --wait --namespace kubecf \
    redis-deployment \
    quarks/helm/redis
```

To destroy cluster and uninstall chart:

```plain
helm delete redis-deployment --purge
```
