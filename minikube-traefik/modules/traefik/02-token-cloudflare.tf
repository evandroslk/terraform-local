resource "kubernetes_secret_v1" "cloudflare_api_token" {
    metadata {
        name = "cloudflare-api-token"
        namespace = kubernetes_namespace_v1.traefik.metadata[0].name
    }

    data = {
        CF_DNS_API_TOKEN = var.cloudflare_api_token
    }

    type = "Opaque"
}