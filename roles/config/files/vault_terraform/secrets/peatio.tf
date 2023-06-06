resource "vault_kv_secret_v2" "peatio_env" {
  mount               = vault_mount.kvv2.path
  name                = "peatio_env"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      # database config (only for unsupported database in vault like questdb)
      kafka_brokers = "${var.kafka_brokers}"
      questdb_host = "${var.questdb_host}",

      vault_addr = "${var.vault_addr}",
      vault_app_name = "${var.vault_app_name}",

      event_api_jwt_public_key = "${var.event_api_jwt_public_key}",
      jwt_public_key = "${var.jwt_public_key}",

      deposit_address_grpc_addr: "${var.deposit_address_grpc_addr}",
      withdraw_grpc_addr: "${var.withdraw_grpc_addr}",
      trade_executor_grpc_addr: "${var.trade_executor_grpc_addr}",
      order_processor_grpc_addr: "${var.order_processor_grpc_addr}",
      matching_grpc_addr: "${var.matching_grpc_addr}",
      code_grpc_addr: "${var.code_grpc_addr}",
      p2p_grpc_addr: "${var.p2p_grpc_addr}",
      conversation_grpc_addr: "${var.conversation_grpc_addr}",
      notify_grpc_addr: "${var.notify_grpc_addr}",
    }
  )
}

data "vault_kv_secret_v2" "peatio_env" {
  mount = vault_mount.kvv2.path
  name  = vault_kv_secret_v2.peatio_env.name
}
