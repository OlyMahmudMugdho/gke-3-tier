#!/bin/bash

# Add and update the repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx 2>/dev/null || true
helm repo update

# Create namespace if it doesn't exist
if ! kubectl get namespace ingress-nginx >/dev/null 2>&1; then
  kubectl create namespace ingress-nginx
  echo "Namespace 'ingress-nginx' created."
else
  echo "Namespace 'ingress-nginx' already exists."
fi

# Install the ingress controller only if not already installed
if ! helm status ingress-nginx -n ingress-nginx >/dev/null 2>&1; then
  helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx
  echo "Ingress NGINX installed."
else
  echo "Ingress NGINX is already installed in namespace 'ingress-nginx'."
fi
