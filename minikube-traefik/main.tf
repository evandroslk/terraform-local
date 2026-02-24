module "traefik" {
    source = "./modules/traefik"
}

module "deploy-teste" {
    source = "./modules/deploy-teste"
    cloudflare_api_token = var.cloudflare_api_token
}