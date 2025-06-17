kubectl apply -f ../k8s/namespace.yaml
kubectl apply -f ../k8s/secret.yaml
kubectl apply -f ../k8s/db-pvc.yaml
kubectl apply -f ../k8s/db-service.yaml
kubectl apply -f ../k8s/db-statefulset.yaml
kubectl apply -f ../k8s/backend-service.yaml
kubectl apply -f ../k8s/backend-deployment.yaml
kubectl apply -f ../k8s/ingress.yaml

