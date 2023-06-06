resource "vault_kv_secret_v2" "barong_env" {
  mount               = vault_mount.kvv2.path
  name                = "barong_env"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      secret_key_base = "${var.secret_key_base}",

      # database config (only for unsupported database in vault like questdb)
      kafka_brokers = "${var.kafka_brokers}",
      questdb_host = "${var.questdb_host}",

      vault_addr = "${var.vault_addr}",
      vault_app_name = "${var.vault_app_name}",

      event_api_jwt_public_key = "${var.event_api_jwt_public_key}",
      jwt_public_key = "${var.jwt_public_key}",
      jwt_private_key = "${var.jwt_private_key}"
    }
  )
}

data "vault_kv_secret_v2" "barong_env" {
  mount = vault_mount.kvv2.path
  name  = vault_kv_secret_v2.barong_env.name
}
