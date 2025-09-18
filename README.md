# David Vizena - Portfolio Project 2: Monitoring & Observability

A comprehensive monitoring and observability solution showcasing David Vizena's DevOps skills, built with Grafana, Prometheus, and Kubernetes.

## 🚀 Features

- **React Frontend**: Modern, responsive UI with Tailwind CSS
- **Grafana Dashboards**: Real-time monitoring and visualization
- **Prometheus Metrics**: Comprehensive metrics collection and alerting
- **Kubernetes Deployment**: Scalable monitoring stack with network policies
- **Alerting System**: Proactive incident response and notifications
- **Log Aggregation**: Centralized logging and analysis

## 🌐 Live Demo

**Live Application**: [View on Vercel](https://your-vercel-url.vercel.app) (coming soon)

**Full Stack Demo**: 
- **Frontend**: React + Tailwind CSS
- **Containerization**: Docker multi-stage build
- **Orchestration**: Kubernetes with LoadBalancer service
- **Networking**: Network policies and health checks

## 🛠️ Tech Stack

- **Frontend**: React 18, Tailwind CSS
- **Monitoring**: Grafana, Prometheus
- **Containerization**: Docker, Nginx
- **Orchestration**: Kubernetes
- **Alerting**: AlertManager, Slack/Email notifications
- **Logging**: ELK Stack (Elasticsearch, Logstash, Kibana)

## 📦 Quick Start

### Prerequisites

- Node.js 18+
- Docker
- Kubernetes cluster (local or cloud)
- kubectl configured

### Local Development

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Start development server**:
   ```bash
   npm start
   ```

3. **Build for production**:
   ```bash
   npm run build
   ```

### Docker Deployment

1. **Build Docker image**:
   ```bash
   docker build -t davidvizena/hello-world:latest .
   ```

2. **Run locally**:
   ```bash
   docker run -p 8080:8080 davidvizena/hello-world:latest
   ```

### Kubernetes Deployment

1. **Start minikube cluster**:
   ```bash
   minikube start
   ```

2. **Deploy to Kubernetes**:
   ```bash
   ./deploy.sh
   ```

3. **Or deploy manually**:
   ```bash
   kubectl apply -f k8s/
   ```

4. **Get service URL**:
   ```bash
   minikube service david-vizena-service -n david-vizena
   ```

## 🌐 Free Hosting Options

### Option 1: Railway
- Connect your GitHub repo to Railway
- Automatic deployments on push
- Free tier available
- Custom domain support

### Option 2: Render
- Connect GitHub repo
- Free tier with custom domains
- Automatic SSL certificates

### Option 3: Vercel
- Perfect for React apps
- Free tier available
- Automatic deployments

## 📁 Project Structure

```
├── src/
│   ├── App.js          # Main React component
│   ├── index.js        # React entry point
│   └── index.css       # Tailwind CSS imports
├── public/
│   └── index.html      # HTML template
├── k8s/
│   ├── namespace.yaml  # Kubernetes namespace
│   ├── deployment.yaml # App deployment
│   ├── service.yaml    # LoadBalancer service
│   └── network-policy.yaml # Network policies
├── Dockerfile          # Multi-stage Docker build
├── nginx.conf          # Nginx configuration
└── deploy.sh           # Deployment script
```

## 🔧 Configuration

### Environment Variables
- `PORT`: Application port (default: 8080)

### Kubernetes Resources
- **CPU**: 50m request, 100m limit
- **Memory**: 64Mi request, 128Mi limit
- **Replicas**: 2 (for high availability)


## 🚀 Portfolio Series Overview

This is **Project 2** of a 4-project portfolio series demonstrating full-stack DevOps skills:

### **Project 1: Foundation** ✅
- ✅ React Frontend + Tailwind CSS
- ✅ Docker Containerization
- ✅ Kubernetes Orchestration
- ✅ Network Policies & Security

### **Project 2: Monitoring & Observability** (Current)
- ✅ Grafana Dashboards
- ✅ Prometheus Metrics
- ✅ Alerting & Incident Response
- ✅ Log Aggregation

### **Project 3: CI/CD & GitOps** (Coming Soon)
- 🔄 GitHub Actions
- 🔄 ArgoCD Deployment
- 🔄 GoCD Pipelines
- 🔄 Automated Testing

### **Project 4: Security & Secrets Management** (Coming Soon)
- 🔄 HashiCorp Vault
- 🔄 RBAC & Access Control
- 🔄 Encryption & Data Protection
- 🔄 Security Scanning

## 📝 License

MIT License - feel free to use this as a template for your own portfolio projects!

---

**Built with ❤️ by David Vizena**
# Test update
