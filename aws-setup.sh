#!/bin/bash

# AWS EKS Setup Script for David Vizena Monitoring Project
# This script sets up a free tier EKS cluster for monitoring demonstration

set -e

echo "🚀 Setting up AWS EKS cluster for monitoring project..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    echo "Visit: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

# Check if eksctl is installed
if ! command -v eksctl &> /dev/null; then
    echo "❌ eksctl is not installed. Please install it first."
    echo "Visit: https://eksctl.io/introduction/installation/"
    exit 1
fi

# Set variables
CLUSTER_NAME="david-vizena-monitoring"
REGION="us-east-1"
NODE_GROUP_NAME="monitoring-nodes"

echo "📋 Configuration:"
echo "  Cluster Name: $CLUSTER_NAME"
echo "  Region: $REGION"
echo "  Node Group: $NODE_GROUP_NAME"

# Create EKS cluster with free tier configuration
echo "☸️  Creating EKS cluster..."
eksctl create cluster \
    --name $CLUSTER_NAME \
    --region $REGION \
    --nodegroup-name $NODE_GROUP_NAME \
    --node-type t3.small \
    --nodes 1 \
    --managed \
    --ssh-access \
    --ssh-public-key ~/.ssh/id_rsa.pub

echo "✅ EKS cluster created successfully!"

# Install AWS Load Balancer Controller
echo "🔧 Installing AWS Load Balancer Controller..."
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

# Create IAM service account for AWS Load Balancer Controller
eksctl create iamserviceaccount \
    --cluster=$CLUSTER_NAME \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --role-name AmazonEKSLoadBalancerControllerRole \
    --attach-policy-arn=arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/AWSLoadBalancerControllerIAMPolicy \
    --approve

# Install AWS Load Balancer Controller via Helm
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=$CLUSTER_NAME \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller

# Install NGINX Ingress Controller
echo "🌐 Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml

# Wait for ingress controller to be ready
echo "⏳ Waiting for NGINX Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=300s

echo "✅ AWS EKS setup complete!"
echo ""
echo "🔗 Next steps:"
echo "1. Update your DNS to point to the Load Balancer IP"
echo "2. Deploy the monitoring stack: ./deploy-monitoring.sh"
echo "3. Access your services:"
echo "   - Grafana: https://grafana.davidvizena.com"
echo "   - Prometheus: https://prometheus.davidvizena.com"
echo ""
echo "📊 To get the Load Balancer IP:"
echo "kubectl get svc -n ingress-nginx"
