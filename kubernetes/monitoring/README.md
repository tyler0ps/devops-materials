# Pull chart to local to view details of configurable values and subcharts
helm pull prometheus-community/kube-prometheus-stack --version 77.9.1
tar -xzf kube-prometheus-stack-77.9.1.tgz

# Enable ingress
minikube addons enable ingress

# Create secret to stores grafana user
kubectl apply -f namespace.yaml
kubectl create secret generic grafana-admin-user-sec -n monitoring --from-literal admin-user=admin --from-literal admin-password=devops123

# Locally install the chart from source
helm install prometheus-stack ./kube-prometheus-stack -f values.tyler.yaml -n monitoring --create-namespace

# Upgrade charts after changing some values or configurations
helm upgrade prometheus-stack ./kube-prometheus-stack -n monitoring -f values.tyler.yaml

# To test locally with minikube
minikube tunnel

Add to /etc/hosts
127.0.0.1 grafana.oceancloud.local

curl http://grafana.oceancloud.local -v
Or, open http://grafana.oceancloud.local from browser

# Troubleshooting service monitor
## Check service-monitor has correct configuration
kubectl get servicemonitors.monitoring.coreos.com -n monitoring prometheus-stack-grafana -o yaml
kubectl get svc -n monitoring -l app.kubernetes.io/instance=prometheus-stack -l app.kubernetes.io/name=grafana -oyaml
kubectl run -it --rm client --image=curlimages/curl --restart=Never -- curl http://prometheus-stack-grafana.monitoring:80/metrics

## To check service-monitor has been selected by prometheus
kubectl -n monitoring get prometheuses.monitoring.coreos.com -oyaml
    serviceMonitorNamespaceSelector: {} --> All namespaces
    serviceMonitorSelector:
      matchLabels:
        release: prometheus-stack 
kubectl get servicemonitors.monitoring.coreos.com --all-namespaces -l release=prometheus-stack