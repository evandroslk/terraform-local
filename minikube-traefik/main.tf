module "traefik" {
    source = "./modules/traefik"

    cloudflare_api_token = var.cloudflare_api_token
}

module "deploy-teste" {
    source = "./modules/deploy-teste"
}