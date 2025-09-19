#!/bin/bash

# Deploy Monitoring Stack to AWS EKS
# This script deploys Grafana, Prometheus, and monitoring components to AWS EKS

set -e

echo "🚀 Deploying monitoring stack to AWS EKS..."

# Check if kubectl is configured for EKS
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ kubectl is not configured for EKS cluster. Please run:"
    echo "aws eks update-kubeconfig --region us-east-1 --name david-vizena-monitoring-v2"
    exit 1
fi

# Check if we're connected to the right cluster
CURRENT_CLUSTER=$(kubectl config current-context)
if [[ ! "$CURRENT_CLUSTER" == *"david-vizena-monitoring-v2"* ]]; then
    echo "❌ Not connected to the correct EKS cluster. Current context: $CURRENT_CLUSTER"
    echo "Please switch to the EKS cluster context."
    exit 1
fi

echo "✅ Connected to EKS cluster: $CURRENT_CLUSTER"

# Create monitoring namespace
echo "📦 Creating monitoring namespace..."
kubectl apply -f infrastructure/kubernetes/monitoring/namespace.yaml

# Deploy Prometheus
echo "📊 Deploying Prometheus..."
kubectl apply -f infrastructure/kubernetes/monitoring/prometheus-rbac.yaml
kubectl apply -f configs/prometheus/prometheus-configmap.yaml
kubectl apply -f infrastructure/kubernetes/monitoring/prometheus-deployment.yaml
kubectl apply -f infrastructure/kubernetes/monitoring/prometheus-service.yaml

# Deploy Node Exporter
echo "🖥️  Deploying Node Exporter..."
kubectl apply -f infrastructure/kubernetes/monitoring/node-exporter.yaml

# Deploy Kube State Metrics
echo "📈 Deploying Kube State Metrics..."
kubectl apply -f infrastructure/kubernetes/monitoring/kube-state-metrics.yaml

# Deploy Grafana
echo "📊 Deploying Grafana..."
kubectl apply -f configs/grafana/grafana-datasources.yaml
kubectl apply -f configs/grafana/grafana-dashboards.yaml
kubectl apply -f configs/grafana/grafana-dashboard-configmap.yaml
kubectl apply -f infrastructure/kubernetes/monitoring/grafana-deployment.yaml
kubectl apply -f infrastructure/kubernetes/monitoring/grafana-service.yaml

# Deploy Ingress for web access
echo "🌐 Deploying Ingress for web access..."
kubectl apply -f infrastructure/kubernetes/ingress/aws-ingress.yaml

# Wait for deployments to be ready
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/prometheus -n monitoring
kubectl wait --for=condition=available --timeout=300s deployment/grafana -n monitoring

# Get service information
echo "✅ Monitoring stack deployed successfully!"
echo ""
echo "📊 Services:"
kubectl get services -n monitoring
echo ""
echo "🌐 Ingress:"
kubectl get ingress -n monitoring
echo ""
echo "🔗 Access URLs (will be available once LoadBalancer is provisioned):"
echo "  Grafana: http://<LOAD_BALANCER_IP>/grafana"
echo "  Prometheus: http://<LOAD_BALANCER_IP>/prometheus"
echo ""
echo "📋 To get the LoadBalancer IP:"
echo "kubectl get ingress -n monitoring -o wide"
echo ""
echo "🔧 To port-forward locally (for testing):"
echo "kubectl port-forward -n monitoring svc/grafana 3000:3000 &"
echo "kubectl port-forward -n monitoring svc/prometheus 9090:9090 &"
