#!/bin/bash

# Simple AWS EKS Setup Script for David Vizena Monitoring Project
# This script creates a minimal EKS cluster that should work with current AWS setup

set -e

echo "🚀 Setting up simple AWS EKS cluster for monitoring project..."

# Check if AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS CLI is not configured. Please run 'aws configure' first."
    exit 1
fi

# Check if eksctl is installed
if ! command -v eksctl &> /dev/null; then
    echo "❌ eksctl is not installed. Please install it first."
    echo "Visit: https://eksctl.io/introduction/installation/"
    exit 1
fi

# Set variables
CLUSTER_NAME="david-vizena-monitoring-v2"
REGION="us-west-2"

echo "📋 Configuration:"
echo "  Cluster Name: $CLUSTER_NAME"
echo "  Region: $REGION"

# Clean up any existing cluster first
echo "🧹 Cleaning up any existing cluster..."
eksctl delete cluster --region=$REGION --name=$CLUSTER_NAME --wait 2>/dev/null || true

# Create EKS cluster with minimal configuration
echo "☸️  Creating EKS cluster with minimal configuration..."
eksctl create cluster \
    --name $CLUSTER_NAME \
    --region $REGION \
    --nodegroup-name workers \
    --node-type t3.medium \
    --nodes 1 \
    --managed \
    --ssh-access \
    --ssh-public-key ~/.ssh/id_rsa.pub \
    --without-nodegroup

echo "✅ EKS cluster created successfully!"

# Create node group separately
echo "👥 Creating node group..."
eksctl create nodegroup \
    --cluster=$CLUSTER_NAME \
    --region=$REGION \
    --name=workers \
    --node-type=t3.medium \
    --nodes=1 \
    --managed

echo "✅ Node group created successfully!"

# Update kubeconfig
echo "🔧 Updating kubeconfig..."
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Verify cluster is working
echo "✅ Verifying cluster..."
kubectl get nodes

echo "🎉 EKS cluster setup complete!"
echo ""
echo "🔗 Next steps:"
echo "1. Deploy the monitoring stack: ./scripts/deployment/deploy-monitoring.sh"
echo "2. Set up ingress for web access"
echo ""
echo "📊 To check cluster status:"
echo "kubectl get nodes"
echo "kubectl get pods --all-namespaces"
