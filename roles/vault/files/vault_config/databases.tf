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
  allowed_roles = [each.value.role]

  postgresql {
    connection_url = "postgres://{{username}}:{{password}}@${var.postgres.host}:${var.postgres.port}/${each.value.database}"
    username       = var.postgres.username
    password       = var.postgres.password
  }
}

resource "vault_database_secret_backend_role" "postgres_role" {
  for_each            = { for role in local.roles : role.name => role }
  backend             = vault_mount.postgres.path
  name                = each.value.role
  db_name             = each.value.database
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
}
