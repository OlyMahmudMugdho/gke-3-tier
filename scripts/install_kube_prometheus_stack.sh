#!/bin/bash

# Create namespace if it doesn't exist
if ! kubectl get namespace monitor >/dev/null 2>&1; then
  kubectl create namespace monitor
  echo "Namespace 'monitor' created."
else
  echo "Namespace 'monitor' already exists."
fi

# Add Helm repo if not already added
if ! helm repo list | grep -q "prometheus-community"; then
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
fi

# Update Helm repos
helm repo update

# Install kube-prometheus-stack only if not already installed
if ! helm status kube-prometheus-stack -n monitor >/dev/null 2>&1; then
  helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack --namespace monitor
  echo "kube-prometheus-stack installed."
else
  echo "kube-prometheus-stack is already installed in namespace 'monitor'."
fi

# Expose Grafana only if the service doesn't exist
if ! kubectl get svc grafana -n monitor >/dev/null 2>&1; then
  kubectl expose deployment kube-prometheus-stack-grafana \
    --port=3000 --target-port=3000 \
    --name=grafana --type=LoadBalancer -n monitor
  echo "Grafana exposed on LoadBalancer port 3000."
else
  echo "Grafana service already exposed."
fi

# Expose Prometheus only if the service doesn't exist
if ! kubectl get svc prometheus-lb -n monitor >/dev/null 2>&1; then
  kubectl expose service kube-prometheus-stack-prometheus \
    --name=prometheus-lb --port=9090 --target-port=9090 \
    --type=LoadBalancer -n monitor
  echo "Prometheus exposed on LoadBalancer port 9090."
else
  echo "Prometheus service already exposed."
fi

# Final output
echo "kube-prometheus stack applied successfully"
echo "Username: admin"
echo "Password: prom-operator"
echo "Grafana running on LoadBalancer at port 3000"
