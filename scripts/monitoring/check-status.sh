#!/bin/bash

# Monitoring Stack Status Checker
# Professional status reporting for employers

set -e

echo "🔍 Kubernetes Monitoring Stack Status Report"
echo "=============================================="
echo ""

# Check cluster connection
echo "📡 Cluster Connection:"
if kubectl cluster-info &> /dev/null; then
    CURRENT_CLUSTER=$(kubectl config current-context)
    echo "✅ Connected to: $CURRENT_CLUSTER"
else
    echo "❌ Not connected to any cluster"
    exit 1
fi
echo ""

# Check namespace
echo "📦 Namespace Status:"
if kubectl get namespace monitoring &> /dev/null; then
    echo "✅ Monitoring namespace exists"
else
    echo "❌ Monitoring namespace not found"
fi
echo ""

# Check pods
echo "🚀 Pod Status:"
kubectl get pods -n monitoring -o wide
echo ""

# Check services
echo "🌐 Service Status:"
kubectl get services -n monitoring
echo ""

# Check ingress
echo "🔗 Ingress Status:"
kubectl get ingress -n monitoring 2>/dev/null || echo "No ingress found"
echo ""

# Check deployments
echo "📊 Deployment Status:"
kubectl get deployments -n monitoring
echo ""

# Check resource usage
echo "💾 Resource Usage:"
kubectl top pods -n monitoring 2>/dev/null || echo "Metrics server not available"
echo ""

# Check logs for any issues
echo "📋 Recent Logs (last 5 lines):"
echo "Grafana:"
kubectl logs -n monitoring deployment/grafana --tail=5 2>/dev/null || echo "Grafana not running"
echo ""
echo "Prometheus:"
kubectl logs -n monitoring deployment/prometheus --tail=5 2>/dev/null || echo "Prometheus not running"
echo ""

# Access information
echo "🔗 Access Information:"
echo "Local Port Forwarding:"
echo "  kubectl port-forward -n monitoring svc/grafana 3000:3000"
echo "  kubectl port-forward -n monitoring svc/prometheus 9090:9090"
echo ""
echo "Web Access:"
echo "  Grafana: http://localhost:3000 (admin/admin123)"
echo "  Prometheus: http://localhost:9090"
echo ""

# Check if LoadBalancer is available
LB_IP=$(kubectl get ingress -n monitoring -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "")
if [ ! -z "$LB_IP" ]; then
    echo "🌐 LoadBalancer Access:"
    echo "  Grafana: http://$LB_IP/grafana"
    echo "  Prometheus: http://$LB_IP/prometheus"
fi

echo ""
echo "✅ Status check complete!"
