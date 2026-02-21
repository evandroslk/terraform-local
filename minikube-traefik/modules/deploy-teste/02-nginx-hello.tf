resource "kubernetes_deployment_v1" "nginx-hello" {
  metadata {
    name      = "nginx-hello"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-hello"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-hello"
        }
      }
      spec {
        container {
          name  = "nginx-hello"
          image = "nginxdemos/nginx-hello"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx-hello" {
    metadata {
        name = "nginx-hello"
        namespace = "default"
    }

    spec {
        selector = {
            app = "nginx-hello"
        }
        port {
            port = 80
            target_port = 8080
        }
        type = "ClusterIP"
    }
}

resource "kubernetes_manifest" "strip_app2" {
    manifest = {
        apiVersion = "traefik.io/v1alpha1"
        kind = "Middleware"
        metadata = {
            name = "strip-app2"
            namespace = "default"
        }
        spec = {
            stripPrefix = {
                prefixes = ["/app2"]
            }
        }
    }
}