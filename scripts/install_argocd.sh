#!/bin/bash

# Create namespace if it doesn't exist
if ! kubectl get namespace argocd >/dev/null 2>&1; then
  kubectl create namespace argocd
  echo "Namespace 'argocd' created."
else
  echo "Namespace 'argocd' already exists."
fi

# Apply Argo CD manifests
echo "Applying Argo CD manifests..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait a few seconds to ensure services are created
sleep 5

# Patch the argocd-server service only if not already LoadBalancer
current_type=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$current_type" != "LoadBalancer" ]; then
  echo "Patching argocd-server service to LoadBalancer..."
  kubectl patch svc argocd-server -n argocd -p '
  {
    "spec": {
      "type": "LoadBalancer",
      "ports": [
        {
          "name": "http",
          "port": 80,
          "protocol": "TCP",
          "targetPort": 8080
        },
        {
          "name": "https",
          "port": 443,
          "protocol": "TCP",
          "targetPort": 8080
        }
      ]
    }
  }'
  echo "Service patched to LoadBalancer."
else
  echo "argocd-server service is already LoadBalancer. Skipping patch."
fi

# Install Argo CD CLI
if ! command -v argocd >/dev/null 2>&1; then
  echo "Installing Argo CD CLI..."
  curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
  rm argocd-linux-amd64
  echo "Argo CD CLI installed to /usr/local/bin/argocd"
else
  echo "Argo CD CLI already installed at $(which argocd)"
fi

echo "Argo CD installation script completed successfully."
