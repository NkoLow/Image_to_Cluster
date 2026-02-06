# 🚀 Projet DevOps : Automatisation Image-to-Cluster

Ce projet implémente une chaîne d'automatisation complète (**CI/CD locale**) pour le déploiement d'une application web.
Il automatise la création d'une image Docker personnalisée, la configuration d'un cluster Kubernetes local, et le déploiement de l'application.

---

## 🏗️ Architecture Technique

Le projet s'appuie sur les principes de l'**Infrastructure as Code (IaC)** avec la stack suivante :

| Outil | Rôle |
| :--- | :--- |
| **Packer** | Construction automatisée de l'image Docker (`my-custom-nginx`) avec injection de contenu (`index.html`). |
| **K3d** | Cluster Kubernetes léger tournant dans Docker (simule un environnement de prod). |
| **Ansible** | Orchestration du déploiement (Application des manifestes Kubernetes `Deployment` & `Service`). |
| **Makefile** | Interface unique pour piloter l'ensemble du cycle de vie du projet. |

---

## ⚠️ PRÉREQUIS : À LIRE AVANT DE DÉMARRER

GitHub Codespaces est un environnement éphémère. Si vous ouvrez ce repository pour la première fois (ou dans un nouveau Codespace), les outils nécessaires (**Packer**, **K3d**, **Ansible**) ne sont pas installés par défaut.

**L'initialisation est automatisée via le Makefile.**

---

## ⚡ Guide de Démarrage (Quick Start)

Ouvrez un terminal et suivez ces deux étapes simples :

### 1. Initialisation de l'environnement
Cette commande installe les dépendances, télécharge les binaires (Packer, K3d, Kubectl) et **crée le cluster Kubernetes** :

```bash
make setup
make all