# WIP experiments for deploying to Kubernetes with Quarks

Commands are run from root of project.

To watch the various resources come to life:

```plain
watch -n1 "kubectl get svc,pod,statefulset,bdpl,ests,esec,ejob,pv,pvc -n scf"
```

To access Redis service from local machine, use `kwt`:

```plain
sudo -E kwt net start --namespace scf
```

In another terminal, discover the hostname for the service and access via `redis-cli`:

```plain
$ kwt net svc -n scf
Services in namespace 'scf'

Name                      Internal DNS                                    Cluster IP    Ports
cf-operator-webhook       cf-operator-webhook.scf.svc.cluster.local       10.20.10.25   443/tcp
redis-deployment          redis-deployment.scf.svc.cluster.local          10.20.14.166  6379/tcp
redis-deployment-redis    redis-deployment-redis.scf.svc.cluster.local    None          6379/tcp
redis-deployment-redis-0  redis-deployment-redis-0.scf.svc.cluster.local  10.20.13.16   6379/tcp

$ redis_password="$(k get secret -n scf redis-deployment.var-redis-password --template '{{.data.password}}' | base64 --decode)"
$ redis-cli -h redis-deployment.scf.svc.cluster.local -a "${redis_password}"
redis-deployment.scf.svc.cluster.local:6379> set hello world
OK
redis-deployment.scf.svc.cluster.local:6379> get hello
"world"
```

## Original redis.yml and operators

```plain
kubectl apply -n scf -f quarks/deployment.yml
```

## Fail fast with Generated Quarks manifest

Fast failure of BOSH operators by running them thru `bosh int` immediately, rather than within `cf-operator`:

```plain
kubectl apply -n scf \
    -f <(./quarks/deployment.sh \
           quarks/operations/gke/gke-persistence.yml \
            quarks/operations/optional/solo.yml)
```

## Helm chart

The `quarks/helm/` folder contains a Helm chart. It includes symlinks to assets in other folders, including the BOSH manifest `manifests/redis.yml`.

```plain
helm upgrade --install --wait --namespace scf \
    redis-deployment \
    quarks/helm
```

To destroy cluster and uninstall chart:

```plain
helm delete redis-deployment --purge
```
