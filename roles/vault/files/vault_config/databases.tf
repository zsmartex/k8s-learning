locals {
  roles = [
    {
      database = "peatio",
      name     = "z-dax_peatio",
      manager  = "peatio_manager",

    },
    {
      database = "barong",
      name     = "z-dax_barong"
      manager  = "barong_manager",
    },
    {
      database = "kouda",
      name     = "z-dax_kouda"
      manager  = "kouda_manager",
    },
    {
      database = "quantex",
      name     = "z-dax_quantex",
      manager  = "quantex_manager",
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
  for_each = { for role in local.roles : role.name => role }
  backend  = vault_mount.postgres.path
  name     = each.value.name
  db_name  = each.value.database
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
  ]
}
