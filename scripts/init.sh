#!/bin/bash
./install_argocd.sh && \
./install_nginx_ingress_controller.sh && \
./install_kube_prometheus_stack.sh && \
kubectl apply -f ../argocd/argocd-app.yaml
