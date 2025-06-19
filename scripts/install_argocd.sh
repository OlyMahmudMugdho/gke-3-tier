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

# Patch the argocd-server service only if not already LoadBalancer
# current_type=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.type}' 2>/dev/null)

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
  echo "Service patched."
else
  echo "argocd-server service is already of type LoadBalancer. Skipping patch."
fi

echo "Argo CD installation script completed successfully."
