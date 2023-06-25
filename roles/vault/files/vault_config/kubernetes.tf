resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "z-dax" {
  backend            = vault_auth_backend.kubernetes.path
  kubernetes_host    = var.kubernetes_host
  kubernetes_ca_cert = var.kubernetes_ca_cert
}

resource "vault_kubernetes_auth_backend_role" "z-dax" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "z-dax"
  bound_service_account_names      = ["z-dax"]
  bound_service_account_namespaces = [var.kubernetes_namespace]
  token_ttl                        = 3600
  token_policies                   = ["z-dax_service_account"]
}

resource "vault_kubernetes_secret_backend" "config" {
  path               = "kubernetes"
  kubernetes_host    = var.kubernetes_host
  kubernetes_ca_cert = var.kubernetes_ca_cert
}

resource "vault_kubernetes_secret_backend_role" "z-dax" {
  backend                       = vault_kubernetes_secret_backend.config.path
  name                          = "z-dax"
  allowed_kubernetes_namespaces = [var.kubernetes_namespace]
  token_max_ttl                 = 43200
  token_default_ttl             = 21600
  service_account_name          = "z-dax"
}
