.DEFAULT_GOAL := cluster

cluster:
	@echo "Criando cluster KIND"
	@kind create cluster --config kind-cluster/cluster.yaml
	@echo "cluster criado com sucesso"


pre:
	@kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
	@kubectl wait --namespace metallb-system \
		--for=condition=ready pod \
		--selector=app=metallb \
		--timeout=300s	
build:
	@docker buildx build --platform linux/amd64,linux/arm64 --push -t juanferreiramf/iti-kubernetes-challenge:latest .

helm:
	@helmfile apply	

tests:
	@kubectl port-forward svc/iti-kubernetes-challenge 8080:80 -n rest-api &
	@kubectl port-forward svc/kube-prometheus-grafana 8089:80 -n monitoring &
	@echo "  REST API: http://localhost:8080"
	@echo "  Grafana: http://localhost:8089"
	@echo "Press Ctrl+C to stop port-forwards"
	@wait

pre-destroy:
	@echo "Removendo MetalLB..."
	@kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml || true
	@echo "MetalLB removido"
