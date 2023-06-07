locals {
  policies = [
    {
      name = "barong"
      path = "policies/barong.tpl"
    },
    {
      name = "peatio"
      path = "policies/peatio.tpl"
    },
    {
      name = "peatio_crypto"
      path = "policies/peatio_crypto.tpl"
    },
    {
      name = "quantex_runner"
      path = "policies/quantex_runner.tpl"
    },
    {
      name = "quantex"
      path = "policies/quantex.tpl"
    }
  ]
}

resource "vault_policy" "peatio" {
  for_each = { for policy in local.policies : policy.name => policy }
  name     = each.value.name

  policy = templatefile("${path.module}/${each.value.path}", {
    app_name = var.app_name,
  })
}

resource "vault_token" "peatio" {
  for_each        = { for policy in local.policies : policy.name => policy }
  policies        = [each.value.name]
  renewable       = true
  ttl             = "1h"
  no_parent       = true
  renew_min_lease = 21600
  renew_increment = 21600
}
