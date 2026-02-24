resource "kubernetes_deployment_v1" "nginx" {
    metadata {
        name = "nginx"
        namespace = "default"
    }

    spec {
        replicas = 1
        selector {
            match_labels = {
                app = "nginx"
            }
        }
        template {
            metadata {
                labels = {
                    app = "nginx"
                }
            }
            spec {
                container {
                    name = "nginx"
                    image = "nginx:alpine"
                    port {
                        container_port = 80
                    }
                }
            }
        }
    }
}

resource "kubernetes_service_v1" "nginx" {
    metadata {
        name = "nginx"
        namespace = "default"
    }

    spec {
        selector = {
            app = "nginx"
        }
        port {
            port = 80
            target_port = 80
        }
        type = "ClusterIP"
    }
}

resource "kubernetes_manifest" "nginx_route" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"

    metadata = {
      name      = "nginx-route"
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
                value = "/app1"
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
              name   = "nginx"
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