resource "helm_release" "traefik" {
    name = "traefik-external"
    namespace = kubernetes_namespace_v1.traefik.metadata[0].name
    repository = "https://traefik.github.io/charts"
    chart = "traefik"

    values = [
        file("${path.module}/values-traefik.yaml")
    ]

    depends_on = [
        kubernetes_secret_v1.cloudflare_api_token
    ]
}