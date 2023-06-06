resource "vault_kv_secret_v2" "quantex_env" {
  mount               = vault_mount.kvv2.path
  name                = "quantex_env"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      vault_addr = "${var.vault_addr}",
      vault_app_name = "${var.vault_app_name}",

      jwt_public_key = "${var.jwt_public_key}",

      runner_grpc_addr = "${var.runner_grpc_addr}"
    }
  )
}

data "vault_kv_secret_v2" "quantex_env" {
  mount = vault_mount.kvv2.path
  name  = vault_kv_secret_v2.quantex_env.name
}
