#!/bin/bash

kubectl apply -f <(cat << '_EOF_'
---
apiVersion: extensions/v1beta1
kind: ReplicaSet
metadata:
  name: hello-world-v2
  labels:
    app: hello-world
    tag: v2
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
        tag: v2
    spec:
      containers:
      - image: kanatakita/print-tag:v2
        name: hello-world
        ports:
        - containerPort: 8080
_EOF_
)
