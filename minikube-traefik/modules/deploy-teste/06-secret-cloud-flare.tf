resource "kubernetes_secret_v1" "cloudflare_api_token" {
    metadata {
        name = "cloudflare-api-token"
        namespace = "cert-manager"
    }

    data = {
        CF_DNS_API_TOKEN = var.cloudflare_api_token
    }

    type = "Opaque"
}