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
helm delete redis-deployment -n kubecf
```

### Ingress Service

You can enhance your deployment with a public LoadBalancer service.

```plain
helm upgrade --install --wait --namespace kubecf \
    redis-deployment \
    quarks/helm/redis \
    --set 'features.ingress.enabled=true'
```

Your cloud should generate a public IP for you, which will be visible to you in the `kubectl get svc` output:

```plain
$ kubectl get svc -l app.kubernetes.io/instance=redis-deployment
NAME                      TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
redis-deployment          ClusterIP      10.0.0.159    <none>          6379/TCP         19m
redis-deployment-public   LoadBalancer   10.0.14.205   34.82.172.107   6379:31669/TCP   4m50s
```

If you have a pre-allocated IP, you can request that this be used for your `LoadBalancer`.

For Google GKE:

```plain
$ gcloud compute addresses create redis-router --region us-west1
$ gcloud compute addresses list
NAME          ADDRESS/RANGE  TYPE      PURPOSE  NETWORK  REGION    SUBNET  STATUS
redis-router  34.82.240.78   EXTERNAL                    us-west1          RESERVED
$ helm upgrade --install --wait --namespace kubecf \
    redis-deployment \
    quarks/helm/redis \
    --set 'features.ingress.enabled=true,services.redis.loadBalancerIP=34.82.240.78'
```

Wait a minute for Google to replace the `EXTERNAL-IP`:

```plain
$ kubectl get svc -l app.kubernetes.io/instance=redis-deployment
NAME                      TYPE           CLUSTER-IP   EXTERNAL-IP    PORT(S)          AGE
redis-deployment          ClusterIP      10.0.0.159   <none>         6379/TCP         23m
redis-deployment-public   LoadBalancer   10.0.3.212   34.82.240.78   6379:31822/TCP   53s
```