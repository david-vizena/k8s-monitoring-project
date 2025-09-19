#!/bin/bash

# Setup ngrok for Public Access
# This script sets up ngrok for immediate public access to Grafana

set -e

echo "🚀 Setting up ngrok for Public Access"
echo "====================================="
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok is not installed."
    echo ""
    echo "📥 Install ngrok:"
    echo "  1. Visit: https://ngrok.com/download"
    echo "  2. Download for your platform"
    echo "  3. Extract and add to PATH"
    echo "  4. Sign up for free account"
    echo "  5. Get auth token from: https://dashboard.ngrok.com/get-started/your-authtoken"
    echo ""
    echo "💡 Or install via Homebrew (macOS):"
    echo "  brew install ngrok/ngrok/ngrok"
    echo ""
    exit 1
fi

echo "✅ ngrok is installed"
echo ""

# Check if port forwarding is active
if ! pgrep -f "kubectl port-forward.*grafana.*3000" > /dev/null; then
    echo "🔌 Starting port forwarding for Grafana..."
    kubectl port-forward -n monitoring svc/grafana 3000:3000 &
    sleep 5
    echo "✅ Port forwarding started"
else
    echo "✅ Port forwarding already active"
fi
echo ""

# Check if port 3000 is accessible
if curl -s http://localhost:3000 > /dev/null; then
    echo "✅ Grafana is accessible on localhost:3000"
else
    echo "❌ Grafana is not accessible on localhost:3000"
    echo "💡 Make sure port forwarding is working"
    exit 1
fi
echo ""

echo "🌐 Starting ngrok tunnel..."
echo "  This will create a public URL for your Grafana instance"
echo "  Press Ctrl+C to stop the tunnel"
echo ""

# Start ngrok
ngrok http 3000
