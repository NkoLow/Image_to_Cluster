packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "nginx" {
  image  = "nginx:latest"
  commit = true
}

build {
  name = "custom-nginx"
  sources = ["source.docker.nginx"]

  # Copie du fichier index.html vers le dossier par défaut de Nginx
  provisioner "file" {
    source      = "index.html"
    destination = "/usr/share/nginx/html/index.html"
  }

  post-processor "docker-tag" {
    repository = "my-custom-nginx"
    tag        = ["latest"]
  }
}
