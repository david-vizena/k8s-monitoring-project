#!/bin/bash

# Build and deploy script for David Vizena Hello World app

set -e

echo "🚀 Building and deploying David Vizena Hello World app..."

# Build Docker image
echo "📦 Building Docker image..."
docker build -t davidvizena/hello-world:latest .

# Load image into minikube (for local development)
echo "📤 Loading image into minikube..."
minikube image load davidvizena/hello-world:latest

# Deploy to Kubernetes
echo "☸️  Deploying to Kubernetes..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/network-policy.yaml

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/david-vizena-app -n david-vizena

# Get service info
echo "🌐 Getting service information..."
kubectl get service david-vizena-service -n david-vizena

echo "✅ Deployment complete!"
echo "🔗 Your app should be accessible via the LoadBalancer external IP"
