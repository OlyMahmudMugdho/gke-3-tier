#!/bin/bash
./install_nginx_ingress_controller.sh && \
./install_kube_prometheus_stack.sh && \
kubectl apply -f ../argo-cd/argocd-app.yaml
