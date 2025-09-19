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

## 🚀 Quick Start

### Prerequisites

- Node.js 18+
- Docker
- Kubernetes cluster (local or cloud)
- kubectl configured
- AWS CLI (for cloud deployment)
- eksctl (for AWS EKS)
- Make (optional, for automation)

### Local Development (Minikube)

#### One-Command Demo Setup

```bash
make demo
```

This will:
1. Start minikube cluster
2. Deploy monitoring stack
3. Setup port forwarding
4. Provide access URLs

#### Manual Setup

```bash
# Start minikube
minikube start

# Deploy monitoring stack
make deploy-monitoring

# Setup port forwarding
make port-forward
```

### AWS EKS Deployment

#### Setup AWS EKS Cluster

```bash
# Create EKS cluster
make setup-aws

# Install AWS Load Balancer Controller
make setup-aws-ingress

# Deploy monitoring stack to AWS
make deploy-aws-monitoring
```

#### Access AWS Deployment

```bash
# Get LoadBalancer URL
kubectl get ingress -n monitoring

# Access services
# Grafana: http://<LOAD_BALANCER_IP>/grafana
# Prometheus: http://<LOAD_BALANCER_IP>/prometheus
```

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
├── infrastructure/
│   ├── aws/                    # AWS EKS configurations
│   └── kubernetes/
│       ├── base/               # Core application manifests
│       ├── monitoring/         # Monitoring stack manifests
│       └── ingress/            # Ingress configurations
├── configs/
│   ├── grafana/                # Grafana dashboards and configs
│   └── prometheus/             # Prometheus configurations
├── scripts/
│   ├── deployment/             # Deployment automation
│   └── monitoring/             # Monitoring setup scripts
├── docs/
│   ├── architecture/           # Architecture documentation
│   └── deployment/             # Deployment guides
├── src/                        # React application source
├── Makefile                    # Professional automation
├── docker-compose.yml          # Local development stack
└── Dockerfile                  # Multi-stage Docker build
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
- ✅ Kubernetes Monitoring Stack
- ✅ AWS EKS Deployment Ready
- ✅ Professional Project Structure

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
