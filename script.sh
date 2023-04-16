#!/bin/bash
if [ -f /tmp/k8s_ready ];then
    echo "Ready"
else
    # echo "Not ready, installing ArgoCD Prometheusand Gerafana"
    # kubectl create namespace argocd
    # kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    # kubectl port-forward -n argocd svc/argocd-server 8080:443
    # kubectl apply -f application.yaml 
    # helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    # helm repo add grafana https://grafana.github.io/helm-charts
    # helm repo update
    # helm install prometheus prometheus-community/prometheus
    # helm install grafana grafana/grafana
    touch /tmp/k8s_ready
fi
