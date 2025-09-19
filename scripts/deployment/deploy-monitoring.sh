#!/bin/bash

# Deploy Monitoring Stack to AWS EKS
# This script deploys Grafana, Prometheus, and AlertManager to the EKS cluster

set -e

echo "🚀 Deploying monitoring stack to AWS EKS..."

# Check if kubectl is configured
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ kubectl is not configured or cluster is not accessible."
    echo "Please run aws-setup.sh first or configure kubectl manually."
    exit 1
fi

# Deploy monitoring namespace and components
echo "📦 Deploying monitoring components..."

# Create monitoring namespace
kubectl apply -f k8s/monitoring/namespace.yaml

# Deploy Prometheus
echo "🔍 Deploying Prometheus..."
kubectl apply -f k8s/monitoring/prometheus-rbac.yaml
kubectl apply -f k8s/monitoring/prometheus-configmap.yaml
kubectl apply -f k8s/monitoring/prometheus-deployment.yaml
kubectl apply -f k8s/monitoring/prometheus-service.yaml

# Deploy Grafana
echo "📊 Deploying Grafana..."
kubectl apply -f k8s/monitoring/grafana-datasources.yaml
kubectl apply -f k8s/monitoring/grafana-dashboards.yaml
kubectl apply -f k8s/monitoring/grafana-deployment.yaml
kubectl apply -f k8s/monitoring/grafana-service.yaml

# Deploy Ingress
echo "🌐 Deploying Ingress..."
kubectl apply -f k8s/monitoring/ingress.yaml

# Wait for deployments to be ready
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/prometheus -n monitoring
kubectl wait --for=condition=available --timeout=300s deployment/grafana -n monitoring

# Get service information
echo "🌐 Getting service information..."
kubectl get svc -n monitoring
kubectl get ingress -n monitoring

echo "✅ Monitoring stack deployed successfully!"
echo ""
echo "🔗 Access your monitoring stack:"
echo "  - Grafana: https://grafana.davidvizena.com (admin/admin123)"
echo "  - Prometheus: https://prometheus.davidvizena.com"
echo ""
echo "📊 To check pod status:"
echo "kubectl get pods -n monitoring"
echo ""
echo "🔍 To view logs:"
echo "kubectl logs -f deployment/grafana -n monitoring"
echo "kubectl logs -f deployment/prometheus -n monitoring"
