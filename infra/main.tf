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
resource "docker_image" "build" {
  name = "build"
  build {
    context = "../app"
    tag     = ["fastapi:latest"]
  }
}

# Run the container
resource "docker_container" "run" {
  image = docker_image.build.image_id
  name  = "fastapi"
  ports {
    internal = 8000
    external = 8000
  }
}