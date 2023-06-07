variable "postgres" {
  type = object({
    username = string
    password = string
    host     = string
    port     = string
  })
  sensitive = true
}

variable "kafka_brokers" {
  type      = string
  sensitive = true
}

# TODO: change to auth method for elasticsearch
variable "elasticsearch_uri" {
  type      = string
  sensitive = true
}

variable "questdb_host" {
  type      = string
  sensitive = true
}

# TODO: use separate vault server for application during security
variable "vault_addr" {
  type      = string
  sensitive = true
}

variable "vault_app_name" {
  type = string
}

variable "event_api_jwt_public_key" {
  type      = string
  sensitive = true
}

variable "jwt_public_key" {
  type      = string
  sensitive = true
}

variable "object_storage" {
  type = object({
    bucket        = string
    endpoint      = string
    region        = string
    access_key    = string
    access_secret = string
    version       = number
  })
  sensitive = true
}

variable "deposit_address_grpc_addr" {
  type      = string
  sensitive = true
}

variable "withdraw_grpc_addr" {
  type      = string
  sensitive = true
}

variable "trade_executor_grpc_addr" {
  type      = string
  sensitive = true
}

variable "order_processor_grpc_addr" {
  type      = string
  sensitive = true
}

variable "matching_grpc_addr" {
  type      = string
  sensitive = true
}

variable "code_grpc_addr" {
  type      = string
  sensitive = true
}

variable "p2p_grpc_addr" {
  type      = string
  sensitive = true
}

variable "conversation_grpc_addr" {
  type      = string
  sensitive = true
}

variable "notify_grpc_addr" {
  type      = string
  sensitive = true
}
