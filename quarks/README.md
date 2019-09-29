# WIP experiments for deploying to Kubernetes with Quarks

Commands are run from root of project.

To watch the various resources come to life:

```plain
watch -n1 "kubectl get svc,pod,statefulset,bdpl,ests,esec,ejob,pv,pvc -n scf"
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
           quarks/operations/gke/persistence.yml \
            quarks/operations/optional/solo.yml)
```

## Helm chart

```plain
helm upgrade --install --wait --namespace scf \
    redis-deployment \
    quarks/helm \
    --set ...
```
