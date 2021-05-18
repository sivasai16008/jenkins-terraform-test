# Specify the provider (GCP, AWS, Azure)
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.1.0"
    }
  }
}

provider "kubernetes" {
  # Configuration options
   config_path = "~/.kube/config"
}