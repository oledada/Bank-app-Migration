terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "bank" {
  metadata {
    name = "bank-migration"
  }
}

resource "kubernetes_deployment" "bank_app" {
  metadata {
    name      = "bank-app"
    namespace = kubernetes_namespace.bank.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "bank-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "bank-app"
        }
      }

      spec {
        container {
          image = "bank-app:latest"
          name  = "bank-app"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
