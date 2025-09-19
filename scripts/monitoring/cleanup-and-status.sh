#!/bin/bash

# Cleanup and Status Script for Monitoring Stack
# This script provides a comprehensive status and cleanup

set -e

echo "🧹 Monitoring Stack Cleanup and Status"
echo "======================================"
echo ""

# Check cluster connection
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Not connected to any Kubernetes cluster"
    exit 1
fi

CURRENT_CLUSTER=$(kubectl config current-context)
echo "📡 Connected to: $CURRENT_CLUSTER"
echo ""

# Show current status
echo "📊 Current Status:"
echo "=================="
kubectl get pods -n monitoring
echo ""
kubectl get svc -n monitoring
echo ""

# Show LoadBalancer status
echo "🌐 LoadBalancer Status:"
LB_URL=$(kubectl get svc grafana-service -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>/dev/null || echo "None")
if [ "$LB_URL" != "None" ] && [ ! -z "$LB_URL" ]; then
    echo "  LoadBalancer URL: $LB_URL"
    LB_IP=$(nslookup $LB_URL 2>/dev/null | grep "Address:" | tail -1 | awk '{print $2}' || echo "Could not resolve")
    echo "  LoadBalancer IP: $LB_IP"
else
    echo "  No LoadBalancer found"
fi
echo ""

# Show port forwarding status
echo "🔌 Port Forwarding Status:"
if pgrep -f "kubectl port-forward" > /dev/null; then
    echo "  ✅ Port forwarding is active"
    echo "  📊 Grafana: http://localhost:3000 (admin/admin123)"
    echo "  📈 Prometheus: http://localhost:9090"
else
    echo "  ❌ No port forwarding active"
    echo "  💡 Run: kubectl port-forward -n monitoring svc/grafana 3000:3000 &"
    echo "  💡 Run: kubectl port-forward -n monitoring svc/prometheus 9090:9090 &"
fi
echo ""

# Cleanup options
echo "🧹 Cleanup Options:"
echo "==================="
echo "1. Clean up failed deployments"
echo "2. Clean up unused services"
echo "3. Clean up LoadBalancer (if not working)"
echo "4. Reset monitoring namespace"
echo "5. Clean up AWS resources"
echo ""

read -p "Choose cleanup option (1-5) or press Enter to skip: " choice

case $choice in
    1)
        echo "🧹 Cleaning up failed deployments..."
        kubectl delete deployment kube-state-metrics -n monitoring --ignore-not-found=true
        echo "✅ Cleanup complete"
        ;;
    2)
        echo "🧹 Cleaning up unused services..."
        kubectl delete svc grafana-loadbalancer -n monitoring --ignore-not-found=true
        kubectl delete svc grafana-nodeport -n monitoring --ignore-not-found=true
        echo "✅ Cleanup complete"
        ;;
    3)
        echo "🧹 Cleaning up LoadBalancer..."
        kubectl delete svc grafana-service -n monitoring --ignore-not-found=true
        echo "✅ Cleanup complete"
        ;;
    4)
        echo "🧹 Resetting monitoring namespace..."
        kubectl delete namespace monitoring --ignore-not-found=true
        echo "✅ Cleanup complete"
        ;;
    5)
        echo "🧹 Cleaning up AWS resources..."
        echo "⚠️  This will delete the entire EKS cluster!"
        read -p "Are you sure? (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            eksctl delete cluster --region=us-east-1 --name=david-vizena-monitoring-v2
            echo "✅ AWS cleanup complete"
        else
            echo "❌ Cleanup cancelled"
        fi
        ;;
    *)
        echo "⏭️  Skipping cleanup"
        ;;
esac

echo ""
echo "✅ Status and cleanup complete!"
