#!/bin/bash

kubectl apply -f <(cat << '_EOF_'
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: hello-world-test
spec:
  hosts:
  - "*"
  gateways:
  - hello-world-gateway
  http:
  - match:
    - uri:
        prefix: "/test"
    rewrite:
      uri: "/"
    route:
    - destination:
        host: hello-world.default.svc.cluster.local
        subset: v2
        port:
          number: 80
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: hello-world-v2
  labels:
    tag: v2
spec:
  host: hello-world.default.svc.cluster.local
  subsets:
  - name: v2
    labels:
      tag: v2
_EOF_
)
