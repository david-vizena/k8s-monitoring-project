#!/bin/bash

# Get Access URLs for Monitoring Stack
# This script provides all the ways to access your monitoring stack

echo "🌐 Kubernetes Monitoring Stack Access URLs"
echo "=========================================="
echo ""

# Check if we're connected to a cluster
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Not connected to any Kubernetes cluster"
    exit 1
fi

CURRENT_CLUSTER=$(kubectl config current-context)
echo "📡 Connected to: $CURRENT_CLUSTER"
echo ""

# Get LoadBalancer services
echo "🌐 LoadBalancer Services:"
kubectl get svc --all-namespaces -o wide | grep LoadBalancer | while read line; do
    echo "  $line"
done
echo ""

# Get NodePort services
echo "🔗 NodePort Services:"
kubectl get svc --all-namespaces -o wide | grep NodePort | while read line; do
    echo "  $line"
done
echo ""

# Get node external IPs
echo "🖥️  Node External IPs:"
kubectl get nodes -o wide | grep -v NAME | while read line; do
    NODE_NAME=$(echo $line | awk '{print $1}')
    EXTERNAL_IP=$(echo $line | awk '{print $7}')
    if [ "$EXTERNAL_IP" != "<none>" ]; then
        echo "  $NODE_NAME: $EXTERNAL_IP"
    fi
done
echo ""

# Port forwarding status
echo "🔌 Port Forwarding (if running):"
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

# LoadBalancer URLs
echo "🌐 LoadBalancer URLs:"
kubectl get svc -n monitoring -o jsonpath='{range .items[?(@.spec.type=="LoadBalancer")]}{.metadata.name}{"\t"}{.status.loadBalancer.ingress[0].hostname}{"\n"}{end}' | while read name hostname; do
    if [ ! -z "$hostname" ]; then
        echo "  📊 $name: http://$hostname"
    fi
done
echo ""

# NodePort URLs
echo "🔗 NodePort URLs:"
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [ ! -z "$NODE_IP" ]; then
    kubectl get svc -n monitoring -o jsonpath='{range .items[?(@.spec.type=="NodePort")]}{.metadata.name}{"\t"}{.spec.ports[0].nodePort}{"\n"}{end}' | while read name port; do
        if [ ! -z "$port" ]; then
            echo "  📊 $name: http://$NODE_IP:$port"
        fi
    done
fi
echo ""

echo "✅ Access information complete!"
echo ""
echo "💡 For employer demo:"
echo "  1. Show local access via port forwarding"
echo "  2. Show LoadBalancer URLs (if working)"
echo "  3. Explain the architecture and setup"
echo "  4. Demonstrate Grafana dashboards"
