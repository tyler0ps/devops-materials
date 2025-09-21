## Install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm show values ingress-nginx/ingress-nginx --version 4.13.2 > nginx-default-values.yaml

helm install ingress-nginx ingress-nginx/ingress-nginx \
    --version 4.13.2 \
    --namespace ingress-nginx \
    --create-namespace \
    -f nginx-values.yaml

