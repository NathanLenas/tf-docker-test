terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Build the image
resource "docker_image" "fastapi" {
  name = "fastapi:latest"
  build {
    context = "../app"
    tag     = ["fastapi:latest"]
  }
}

# Run the container
resource "docker_container" "fastapi" {
  image = docker_image.fastapi.image_id
  name  = "fastapi"
  ports {
    internal = 8000
    external = 8000
  }
}