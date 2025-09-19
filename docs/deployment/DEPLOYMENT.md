# Deployment Guide

## Prerequisites
- Docker
- Kubernetes cluster (minikube, EKS, or other)
- kubectl configured
- Node.js 18+ (for local development)

## Local Development (Minikube)

### 1. Start Minikube
```bash
minikube start
```

### 2. Deploy Monitoring Stack
```bash
./scripts/deployment/deploy-monitoring.sh
```

### 3. Access Services
```bash
# Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000
# Access: http://localhost:3000 (admin/admin123)

# Prometheus
kubectl port-forward -n monitoring svc/prometheus 9090:9090
# Access: http://localhost:9090
```

## Production Deployment (AWS EKS)

### 1. Setup AWS Infrastructure
```bash
./infrastructure/aws/eks-simple-setup.sh
```

### 2. Deploy Application
```bash
./scripts/deployment/deploy.sh
```

### 3. Deploy Monitoring
```bash
./scripts/deployment/deploy-monitoring.sh
```

## Verification
```bash
# Check pod status
kubectl get pods -n monitoring

# Check services
kubectl get svc -n monitoring

# View logs
kubectl logs -f deployment/grafana -n monitoring
kubectl logs -f deployment/prometheus -n monitoring
```

## Troubleshooting
- Ensure all pods are in Running state
- Check resource limits and requests
- Verify network policies allow traffic
- Review Prometheus targets in UI
