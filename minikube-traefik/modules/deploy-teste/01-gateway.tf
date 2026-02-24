resource "kubernetes_manifest" "gateway_api" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"

    metadata = {
      name      = "gateway-api"
      namespace = "default"
    }

    spec = {
      gatewayClassName = "traefik"

      listeners = [
        {
          name     = "http"
          protocol = "HTTP"
          port     = 8000

          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        },
        {
          name     = "https"
          protocol = "HTTPS"
          port     = 8443
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                name = "evandro-certificate"
              }
            ]
          }

          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        }
      ]
    }
  }
}