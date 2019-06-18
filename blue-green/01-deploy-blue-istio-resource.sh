#!/bin/bash

kubectl apply -f <(cat <<'_EOF_'
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: hello-world-gateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
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
        subset: v1
        port:
          number: 80
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: hello-world-v1
  labels:
    tag: v1
spec:
  host: hello-world.default.svc.cluster.local
  subsets:
  - name: v1
    labels:
      tag: v1
_EOF_
)
