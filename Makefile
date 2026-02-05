# --- INSTALLATION & CONFIGURATION ---
setup:
	@echo "🛠️  Mise à jour du système..."
	sudo apt-get update || true
	sudo apt-get install unzip -y

	@echo "🛠️  Installation de Packer..."
	wget -q https://releases.hashicorp.com/packer/1.10.1/packer_1.10.1_linux_amd64.zip
	unzip -o packer_1.10.1_linux_amd64.zip
	sudo mv packer /usr/local/bin/
	rm packer_1.10.1_linux_amd64.zip

	@echo "🛠️  Installation d'Ansible..."
	pip install ansible kubernetes
	ansible-galaxy collection install kubernetes.core

	@echo "🛠️  Installation de K3d & Kubectl..."
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
	curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	sudo mv kubectl /usr/local/bin/

	@echo "🏗️  Création du cluster K3d 'lab'..."
	k3d cluster create lab --servers 1 --agents 2 || echo "⚠️ Le cluster existe déjà, on continue..."

	@echo "✅ Environnement prêt à 100% !"

# --- CONSTRUCTION ---
build:
	packer init build.pkr.hcl
	packer build build.pkr.hcl

# --- DÉPLOIEMENT ---
deploy:
	k3d image import my-custom-nginx:latest -c lab
	ansible-playbook deploy.yml

# --- ACCÈS ---
forward:
	@echo "🔗 Accès à l'application sur : http://localhost:8081"
	kubectl port-forward svc/nginx-service 8081:80

stop:
	pkill -f "kubectl port-forward" || true

# --- AUTOMATISATION TOTALE ---
all: build deploy forward