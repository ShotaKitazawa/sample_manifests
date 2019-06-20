#!/bin/sh

function kube_delete () {
for i in $(kubectl get $1 --sort-by=.metadata.creationTimestamp -oname | cut -d/ -f2); do
  kubectl delete $1 $i
done
}

kube_delete rs
kube_delete svc
kube_delete gateways
kube_delete virtualservices
kube_delete destinationrules
