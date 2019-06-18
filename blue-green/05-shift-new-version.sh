#!/bin/bash

kubectl apply -f <(cat << '_EOF_'
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: hello-world
spec:
  hosts:
  - "*"
  gateways:
  - hello-world-gateway
  http:
  - route:
    - destination:
        host: hello-world.default.svc.cluster.local
        subset: v2
        port:
          number: 80
_EOF_
)

kubectl delete virtualservices.networking.istio.io hello-world-test

# Delete Oldest one
kubectl delete rs $(kubectl get rs --sort-by=.metadata.creationTimestamp -oname | head -n1 | cut -d/ -f2)
kubectl delete destinationrules $(kubectl get destinationrules --sort-by=.metadata.creationTimestamp -oname | head -n1 | cut -d/ -f2)
