# View the kv v2 data
path "secret/data/${app_name}/*" {
  capabilities = ["read", "list"]
}

# View the kv v2 metadata
path "secret/metadata/${app_name}/*" {
  capabilities = ["read", "list"]
}

# Manage the transit secrets engine
path "transit/keys/${app_name}_kaigara_*" {
  capabilities = ["create", "read", "list", "update"]
}

# Encrypt secrets data
path "transit/encrypt/${app_name}_kaigara_*" {
  capabilities = ["create", "read", "update"]
}

# Decrypt secrets data
path "transit/decrypt/${app_name}_kaigara_*" {
  capabilities = ["create", "read", "update"]
}

# Renew tokens
path "auth/token/renew" {
  capabilities = ["update"]
}

# Lookup tokens
path "auth/token/lookup" {
  capabilities = ["update"]
}
