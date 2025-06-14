kubectl delete -f secret.yaml
kubectl delete -f db-pvc.yaml
kubectl delete -f db-service.yaml
kubectl delete -f db-statefulset.yaml
kubectl delete -f backend-service.yaml
kubectl delete -f backend-deployment.yaml
kubectl delete -f ingress.yaml
