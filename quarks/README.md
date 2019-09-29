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
        manifests/operators/quarks/gke/persistence.yml \
        manifests/operators/quarks/optional/solo.yml)
```
