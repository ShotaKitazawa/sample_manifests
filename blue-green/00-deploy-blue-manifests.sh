#!/bin/bash

kubectl apply -f <(cat <<'_EOF_'
---
apiVersion: extensions/v1beta1
kind: ReplicaSet
metadata:
  name: hello-world-v1
  labels:
    app: hello-world
    tag: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
        tag: v1
    spec:
      containers:
      - image: kanatakita/print-tag:v1
        name: hello-world
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: hello-world
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  selector:
    app: hello-world
  type: ClusterIP
_EOF_
)
