locals {
  roles = [
    {
      database = "peatio",
      name     = "z-dax_peatio"
    },
    {
      database = "barong",
      name     = "z-dax_barong"
    },
    {
      database = "kouda",
      name     = "z-dax_kouda"
    },
    {
      database = "quantex",
      name     = "z-dax_quantex"
    },
  ]
}

resource "vault_mount" "postgres" {
  path = "postgres"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  for_each      = { for role in local.roles : role.name => role }
  backend       = vault_mount.postgres.path
  name          = each.value.database
  allowed_roles = [each.value.name]

  postgresql {
    connection_url = "postgres://{{username}}:{{password}}@${var.postgresql_host}:${var.postgresql_port}/${each.value.database}"
    username       = var.postgresql_username
    password       = var.postgresql_password
  }
}

resource "vault_database_secret_backend_role" "postgres_role" {
  for_each            = { for role in local.roles : role.name => role }
  backend             = vault_mount.postgres.path
  name                = each.value.name
  db_name             = each.value.database
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
}
