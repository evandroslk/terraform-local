resource "kubernetes_manifest" "evandro_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      name      = "evandro-certificate"
      namespace = "default"
    }

    spec = {
      secretName = "evandro-certificate"

      issuerRef = {
        name = "letsencrypt-dns-prod"
        kind = "ClusterIssuer"
      }

      dnsNames = [
        "k8s.evandrolovato.site"
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.letsencrypt_dns_prod
  ]
}