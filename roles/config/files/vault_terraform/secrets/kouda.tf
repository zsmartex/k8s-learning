resource "vault_kv_secret_v2" "kouda_env" {
  mount               = vault_mount.kvv2.path
  name                = "kouda_env"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      event_api_jwt_public_key = "${var.event_api_jwt_public_key}",
      jwt_public_key = "${var.jwt_public_key}",

      crypto_compare_api_key = "${var.crypto_compare_api_key}",
    }
  )
}

data "vault_kv_secret_v2" "kouda_env" {
  mount = vault_mount.kvv2.path
  name  = vault_kv_secret_v2.kouda_env.name
}
