kubectl create ns monitor && \
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update && \
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack --namespace monitor && \
kubectl expose deployment kube-prometheus-stack-grafana --port=3000 --target-port=3000 --name=grafana --type=LoadBalancer -n monitor && \
kubectl expose service kube-prometheus-stack-prometheus -n monitor --name=prometheus-lb --port=9090 --target-port=9090 --type=LoadBalancer && \
echo "kube-prometheus stack installed and applied successfully" && \
echo "Username: admin" && \
echo "Password: prom-operator" && \
echo "Running on port 3000 of the load  balancer"
