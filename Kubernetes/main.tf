resource "kubernetes_deployment" "nginx" {
  metadata {
    name = var.name
    labels = var.labels
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = var.labels
    }
    template {
      metadata {
        labels = var.labels
      }
      spec {
        container {
          image = var.image
          name  = var.name

          port {
            container_port = var.port
          }

          resources {
            limits = var.limits
            requests = var.requests
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = var.name 
  }
  spec {
    selector = var.labels
    port {
      node_port   = var.node_port
      port        = var.port 
      target_port = var.target_port
    }

    type = "NodePort"
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "example" {
  metadata {
    name = var.name
  }

  spec {
    max_replicas = var.hpa_replicas_max
    min_replicas = var.hpa_replicas_min

    scale_target_ref {
      kind = "Deployment"
      name = var.name
    }
  }
}
