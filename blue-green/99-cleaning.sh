#!/bin/sh

kubectl delete rs hello-world-v1
kubectl delete rs hello-world-v2
kubectl delete svc hello-world
kubectl delete gateways.networking.istio.io hello-world-gateway
kubectl delete virtualservices.networking.istio.io hello-world
kubectl delete virtualservices.networking.istio.io hello-world-test
kubectl delete destinationrules.networking.istio.io hello-world-v1
kubectl delete destinationrules.networking.istio.io hello-world-v2
