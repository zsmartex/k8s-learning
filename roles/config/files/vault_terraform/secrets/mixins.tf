resource "vault_kv_secret_v2" "object_storage" {
  mount               = vault_mount.kvv2.path
  name                = "object_storage"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(var.object_storage)
}

data "vault_kv_secret_v2" "object_storage" {
  mount = vault_mount.kvv2.path
  name  = vault_kv_secret_v2.object_storage.name
}
