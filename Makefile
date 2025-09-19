# Kubernetes Monitoring Project Makefile
# Professional DevOps automation for monitoring stack

.PHONY: help build deploy clean test lint docs

# Default target
help: ## Show this help message
	@echo "Kubernetes Monitoring Project"
	@echo "=============================="
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development targets
build: ## Build React application
	npm run build

dev: ## Start development server
	npm start

# Infrastructure targets
setup-minikube: ## Setup local minikube cluster
	minikube start
	minikube addons enable ingress

setup-aws: ## Setup AWS EKS cluster
	./infrastructure/aws/aws-setup.sh

# Deployment targets
deploy-app: ## Deploy main application
	./scripts/deployment/deploy.sh

deploy-monitoring: ## Deploy monitoring stack
	./scripts/deployment/deploy-monitoring.sh

deploy-all: deploy-app deploy-monitoring ## Deploy everything

# Monitoring targets
port-forward: ## Setup port forwarding for local access
	@echo "Setting up port forwarding..."
	@echo "Grafana: http://localhost:3000 (admin/admin123)"
	@echo "Prometheus: http://localhost:9090"
	kubectl port-forward -n monitoring svc/grafana 3000:3000 &
	kubectl port-forward -n monitoring svc/prometheus 9090:9090 &

status: ## Check deployment status
	@echo "=== Pod Status ==="
	kubectl get pods -n monitoring
	@echo ""
	@echo "=== Services ==="
	kubectl get svc -n monitoring
	@echo ""
	@echo "=== Ingress ==="
	kubectl get ingress -n monitoring

logs: ## View monitoring logs
	kubectl logs -f deployment/grafana -n monitoring

# Cleanup targets
clean: ## Clean up all resources
	kubectl delete namespace monitoring --ignore-not-found=true
	kubectl delete namespace david-vizena --ignore-not-found=true

clean-aws: ## Clean up AWS resources
	eksctl delete cluster --region=us-east-1 --name=david-vizena-monitoring

# Utility targets
lint: ## Run linting
	npm run lint

test: ## Run tests
	npm test

docs: ## Generate documentation
	@echo "Documentation available in docs/ directory"

# Quick start for employers
demo: setup-minikube deploy-monitoring port-forward ## Quick demo setup
	@echo "Demo ready! Access Grafana at http://localhost:3000"
