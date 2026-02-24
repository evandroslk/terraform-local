resource "helm_release" "traefik" {
    name = "traefik-external"
    namespace = "traefik"
    create_namespace = true
    repository = "https://traefik.github.io/charts"
    chart = "traefik"

    values = [
        file("${path.module}/values.yaml")
    ]
}
