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

resource "kubernetes_manifest" "nginx_hello_route" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"

    metadata = {
      name      = "nginx-hello-route"
      namespace = "default"
    }

    spec = {
      parentRefs = [
        {
          name        = "gateway-api"
          kind        = "Gateway"
        }
      ]

      hostnames = [
        "k8s.evandrolovato.site"
      ]

      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/app2"
              }
            }
          ]

          filters = [
            {
              type = "URLRewrite"
              urlRewrite = {
                path = {
                  type               = "ReplacePrefixMatch"
                  replacePrefixMatch = "/"
                }
              }
            }
          ]

          backendRefs = [
            {
              name   = "nginx-hello"
              port   = 80
              weight = 1
            }
          ]
        }
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.gateway_api
  ]
}