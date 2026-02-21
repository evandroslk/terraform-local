resource "kubernetes_manifest" "nginx_ingress" {
    manifest = {
        apiVersion = "traefik.io/v1alpha1"
        kind = "IngressRoute"
        metadata = {
            name = "nginx-route"
            namespace = "default"
        }
        spec = {
            entryPoints = ["websecure"]
            routes = [
                {
                    match = "Host(`k8s.evandrolovato.site`) && PathPrefix(`/app1`)"
                    kind = "Rule"
                    services = [
                        {
                            name = "nginx"
                            port = 80
                        }
                    ]
                    middlewares = [
                        {
                            name: "strip-app1"
                        }
                    ]
                },
                {
                    match = "Host(`k8s.evandrolovato.site`) && PathPrefix(`/app2`)"
                    kind = "Rule"
                    services = [
                        {
                            name = "nginx-hello"
                            port = 80
                        }
                    ]
                    middlewares = [
                        {
                            name: "strip-app2"
                        }
                    ]
                }
            ]
            tls = {
                certResolver = "cloudflare"
            }
        }
    }
}