# Manage the transit secrets engine
path "transit/keys/${app_name}_*" {
  capabilities = ["create", "read", "list"]
}
# Encrypt engines secrets
path "transit/encrypt/${app_name}_engines_*" {
  capabilities = ["create", "read", "update"]
}
# Encrypt wallets secrets
path "transit/encrypt/${app_name}_wallets_*" {
  capabilities = ["create", "read", "update"]
}
# Encrypt beneficiaries data
path "transit/encrypt/${app_name}_beneficiaries_*" {
  capabilities = [ "create", "read", "update" ]
}
# Decrypt beneficiaries data
path "transit/decrypt/${app_name}_beneficiaries_*" {
  capabilities = [ "create", "read", "update" ]
}
# Encrypt blockchains data
path "transit/encrypt/${app_name}_blockchains_*" {
  capabilities = [ "create", "read", "update" ]
}
# Decrypt blockchains data
path "transit/decrypt/${app_name}_blockchains_*" {
  capabilities = [ "create", "read", "update" ]
}
# Renew tokens
path "auth/token/renew" {
  capabilities = ["update"]
}
# Lookup tokens
path "auth/token/lookup" {
  capabilities = ["update"]
}
# Verify an otp code
path "totp/code/{app_name}_*" {
  capabilities = ["update"]
}
