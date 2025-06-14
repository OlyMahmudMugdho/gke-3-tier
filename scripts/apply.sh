kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f db-pvc.yaml
kubectl apply -f db-service.yaml
kubectl apply -f db-statefulset.yaml
kubectl apply -f backend-service.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f ingress.yaml
