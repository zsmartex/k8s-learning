output "vault_token" {
  value = {
    for k, v in vault_token.z-dax : k => v.client_token
  }
  sensitive = true
}
