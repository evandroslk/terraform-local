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

resource "kubernetes_manifest" "strip_app1" {
    manifest = {
        apiVersion = "traefik.io/v1alpha1"
        kind = "Middleware"
        metadata = {
            name = "strip-app1"
            namespace = "default"
        }
        spec = {
            stripPrefix = {
                prefixes = ["/app1"]
            }
        }
    }
}