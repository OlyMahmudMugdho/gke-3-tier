kubectl delete -f ../k8s/secret.yaml
kubectl delete -f ../k8s/db-pvc.yaml
kubectl delete -f ../k8s/db-service.yaml
kubectl delete -f ../k8s/db-statefulset.yaml
kubectl delete -f ../k8s/backend-service.yaml
kubectl delete -f ../k8s/backend-deployment.yaml
kubectl delete -f ../k8s/ingress.yaml
