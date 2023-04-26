#!/bin/bash
if [ -f /tmp/k8s_ready ];then
    echo "Ready"
else
    echo "Not ready, installing ArgoCD Prometheusand Gerafana"
    # Install ArgoCD
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    sleep 300
    kubectl create namespace app
    kubectl create secret docker-registry nexus --docker-server=http://${NEXUS_IP}:5000 --docker-username=${NEXUS_USERNAME} --docker-password=${NEXUS_PASSWORD} --docker-email=none --namespace=app
    kubectl apply -f k8s/argo.yaml
    
    # Adding Helm Repos
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo add nginx-stable https://helm.nginx.com/stable
    helm repo update

    # Install Prometheus Grafana Nginx controller
    helm install prometheus prometheus-community/prometheus
    helm install grafana grafana/grafana
    helm install my-release nginx-stable/nginx-ingress

    # to not do the same steps again on every pipeline run
    touch /tmp/k8s_ready
fi
