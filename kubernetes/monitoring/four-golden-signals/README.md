## Install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm show values ingress-nginx/ingress-nginx --version 4.13.2 > nginx-default-values.yaml

helm install ingress-nginx ingress-nginx/ingress-nginx \
    --version 4.13.2 \
    --namespace ingress-nginx \
    --create-namespace \
    -f nginx-values.yaml

# Test metric endpoint
kubectl run client \
    -it --rm \
    --image=curlimages/curl \
    --restart=Never \
    -- curl http://ingress-nginx-controller-metrics.ingress-nginx:10254/metrics

# Add cluster role to prometheus service-account to scrape ingress-nginx-controller
kubectl apply -f prometheus

# Build applications that be deployed behind nginx
docker build -t hoangthai9217/nginx-crud-app .
docker push hoangthai9217/nginx-crud-app
kubectl apply -f my-app

# Test application is up
Add to host file
127.0.0.1 api.devopsbyexample.com
curl http://api.devopsbyexample.com/devices

# Do some application API tests
cd cmd/client
go get .
go run .
 
# Go to prometheus make a query, to test metrics are scraped
PromQL nginx_ingress_controller_request_duration_seconds_bucket

# Import dashboards
latency-traffic-errors.json
saturation.json
