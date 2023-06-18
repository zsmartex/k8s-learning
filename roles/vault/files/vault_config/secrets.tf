# Still high risk stop doing this
# locals {
#   secrets = {
#     peatio = {
#       es_url                    = var.es_url
#       kafka_brokers             = var.kafka_brokers
#       questdb_host              = var.questdb_host
#       vault_addr                = var.vault_addr
#       vault_app_name            = var.vault_app_name
#       event_api_jwt_public_key  = var.event_api_jwt_public_key
#       jwt_public_key            = var.jwt_public_key
#       deposit_address_grpc_addr = var.deposit_address_grpc_addr
#       withdraw_grpc_addr        = var.withdraw_grpc_addr
#       trade_executor_grpc_addr  = var.trade_executor_grpc_addr
#       order_processor_grpc_addr = var.order_processor_grpc_addr
#       matching_grpc_addr        = var.matching_grpc_addr
#       code_grpc_addr            = var.code_grpc_addr
#       p2p_grpc_addr             = var.p2p_grpc_addr
#       conversation_grpc_addr    = var.conversation_grpc_addr
#       notify_grpc_addr          = var.notify_grpc_addr
#     }

#     barong = {
#       es_url                   = var.es_url
#       secret_key_base          = var.secret_key_base
#       kafka_brokers            = var.kafka_brokers
#       questdb_host             = var.questdb_host
#       vault_addr               = var.vault_addr
#       vault_app_name           = var.vault_app_name
#       event_api_jwt_public_key = var.event_api_jwt_public_key
#       jwt_public_key           = var.jwt_public_key
#       jwt_private_key          = var.jwt_private_key
#     }

#     kouda = {
#       event_api_jwt_public_key = var.event_api_jwt_public_key
#       jwt_public_key           = var.jwt_public_key
#       crypto_compare_api_key   = var.crypto_compare_api_key
#     }

#     quantex = {
#       vault_addr       = var.vault_addr
#       vault_app_name   = var.vault_app_name
#       jwt_public_key   = var.jwt_public_key
#       runner_grpc_addr = var.runner_grpc_addr
#     }
#   }
# }

# resource "vault_mount" "kvv2" {
#   path        = "kvv2"
#   type        = "kv"
#   options     = { version = "2" }
#   description = "KV Version 2 secret engine mount"
# }

# resource "vault_kv_secret_v2" "peatio_env" {
#   mount               = vault_mount.kvv2.path
#   name                = "peatio_env"
#   cas                 = 1
#   delete_all_versions = true
#   data_json           = jsonencode(local.secrets.peatio)
# }

# data "vault_kv_secret_v2" "peatio_env" {
#   mount = vault_mount.kvv2.path
#   name  = vault_kv_secret_v2.peatio_env.name
# }

# resource "vault_kv_secret_v2" "barong_env" {
#   mount               = vault_mount.kvv2.path
#   name                = "barong_env"
#   cas                 = 1
#   delete_all_versions = true
#   data_json           = jsonencode(local.secrets.barong)
# }

# data "vault_kv_secret_v2" "barong_env" {
#   mount = vault_mount.kvv2.path
#   name  = vault_kv_secret_v2.barong_env.name
# }

# resource "vault_kv_secret_v2" "kouda_env" {
#   mount               = vault_mount.kvv2.path
#   name                = "kouda_env"
#   cas                 = 1
#   delete_all_versions = true
#   data_json           = jsonencode(local.secrets.kouda)
# }

# data "vault_kv_secret_v2" "kouda_env" {
#   mount = vault_mount.kvv2.path
#   name  = vault_kv_secret_v2.kouda_env.name
# }

# resource "vault_kv_secret_v2" "quantex_env" {
#   mount               = vault_mount.kvv2.path
#   name                = "quantex_env"
#   cas                 = 1
#   delete_all_versions = true
#   data_json           = jsonencode(local.secrets.quantex)
# }

# data "vault_kv_secret_v2" "quantex_env" {
#   mount = vault_mount.kvv2.path
#   name  = vault_kv_secret_v2.quantex_env.name
# }

# resource "vault_kv_secret_v2" "object_storage" {
#   mount               = vault_mount.kvv2.path
#   name                = "object_storage"
#   cas                 = 1
#   delete_all_versions = true
#   data_json           = jsonencode(var.object_storage)
# }

# data "vault_kv_secret_v2" "object_storage" {
#   mount = vault_mount.kvv2.path
#   name  = vault_kv_secret_v2.object_storage.name
# }
