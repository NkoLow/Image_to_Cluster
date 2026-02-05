setup:
	pip install ansible kubernetes
	ansible-galaxy collection install kubernetes.core

build:
	packer init build.pkr.hcl
	packer build build.pkr.hcl

deploy:
	k3d image import my-custom-nginx:latest -c lab
	ansible-playbook deploy.yml

forward:
	@echo "🔗 Accès à l'application sur : http://localhost:8081"
	kubectl port-forward svc/nginx-service 8081:80

# TUE les anciens port-forwards (utile si tu as l'erreur "address already in use")
stop:
	pkill -f "kubectl port-forward" || true

# La commande magique pour tout faire d'un coup
all: build deploy forward
