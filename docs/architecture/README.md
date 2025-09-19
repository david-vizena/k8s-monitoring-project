# Kubernetes Monitoring Architecture

## Overview
This project demonstrates a comprehensive monitoring and observability solution for Kubernetes environments using Grafana, Prometheus, and related tools.

## Architecture Components

### Core Monitoring Stack
- **Prometheus**: Metrics collection and storage
- **Grafana**: Visualization and dashboards
- **Node Exporter**: Node-level metrics collection
- **Kube State Metrics**: Kubernetes cluster state metrics

### Infrastructure
- **Kubernetes**: Container orchestration platform
- **AWS EKS**: Managed Kubernetes service (production)
- **Minikube**: Local development environment

## Directory Structure

```
├── infrastructure/
│   ├── aws/                    # AWS-specific configurations
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
└── src/                        # React application source
```

## Key Features
- Real-time Kubernetes cluster monitoring
- Custom Grafana dashboards
- Prometheus alerting rules
- Comprehensive metrics collection
- Production-ready configurations
- Infrastructure as Code (IaC)

## Technologies Used
- **Frontend**: React 18, Tailwind CSS
- **Monitoring**: Grafana, Prometheus, Node Exporter
- **Infrastructure**: Kubernetes, AWS EKS, Docker
- **Automation**: Bash scripts, YAML manifests
