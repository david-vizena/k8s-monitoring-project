#!/bin/bash

# Setup Custom Domain for Monitoring Stack
# This script helps set up a custom domain for the monitoring stack

set -e

echo "🌐 Setting up Custom Domain for Monitoring Stack"
echo "================================================"
echo ""

# Get the current LoadBalancer URL
LB_URL=$(kubectl get svc grafana-service -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>/dev/null || echo "")

if [ -z "$LB_URL" ]; then
    echo "❌ No LoadBalancer found. Please ensure Grafana service is running."
    exit 1
fi

echo "📡 Current LoadBalancer: $LB_URL"
echo ""

# Get LoadBalancer IP
LB_IP=$(nslookup $LB_URL | grep "Address:" | tail -1 | awk '{print $2}' || echo "")

if [ -z "$LB_IP" ]; then
    echo "❌ Could not resolve LoadBalancer IP"
    exit 1
fi

echo "🌐 LoadBalancer IP: $LB_IP"
echo ""

echo "🔧 Domain Setup Options:"
echo ""
echo "Option 1: Free Domain Services"
echo "  - Freenom (freenom.com) - Free .tk, .ml, .ga domains"
echo "  - No-IP (noip.com) - Free subdomains"
echo "  - DuckDNS (duckdns.org) - Free subdomains"
echo ""
echo "Option 2: Paid Domain Services"
echo "  - Namecheap - $1-2/month for .com domains"
echo "  - GoDaddy - $1-2/month for .com domains"
echo "  - Cloudflare - $1/month for .com domains"
echo ""
echo "Option 3: Demo with ngrok (Temporary)"
echo "  - ngrok provides temporary public URLs"
echo "  - Perfect for demos and testing"
echo ""

echo "📋 DNS Configuration:"
echo "  Once you have a domain, create an A record:"
echo "  Type: A"
echo "  Name: @ (or subdomain like 'monitoring')"
echo "  Value: $LB_IP"
echo "  TTL: 300 (5 minutes)"
echo ""

echo "🔒 SSL Certificate (Optional):"
echo "  - Use AWS Certificate Manager (ACM) for free SSL"
echo "  - Or use Let's Encrypt with cert-manager"
echo ""

echo "💡 Recommended for Demo:"
echo "  1. Use ngrok for immediate public access"
echo "  2. Set up a free domain for permanent access"
echo "  3. Add SSL certificate for professional look"
echo ""

echo "🚀 Quick Start with ngrok:"
echo "  1. Install ngrok: https://ngrok.com/download"
echo "  2. Run: ngrok http 3000"
echo "  3. Use the provided URL for public access"
echo ""

echo "✅ Domain setup information complete!"
