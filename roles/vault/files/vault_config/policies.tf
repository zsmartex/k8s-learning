locals {
  policies = [
    {
      name = "kaigara"
      path = "policies/kaigara.hcl"
    },
    {
      name = "barong"
      path = "policies/barong.hcl"
    },
    {
      name = "peatio"
      path = "policies/peatio.hcl"
    },
    {
      name = "peatio_crypto"
      path = "policies/peatio_crypto.hcl"
    },
    {
      name = "quantex_runner"
      path = "policies/quantex_runner.hcl"
    },
    {
      name = "quantex"
      path = "policies/quantex.hcl"
    }
  ]
}

resource "vault_policy" "z-dax" {
  for_each = { for policy in local.policies : policy.name => policy }
  name     = each.value.name

  policy = templatefile("${path.module}/${each.value.path}", {
    app_name = var.app_name,
  })
}

resource "vault_token" "z-dax" {
  for_each        = { for policy in local.policies : policy.name => policy }
  policies        = [each.value.name]
  renewable       = true
  ttl             = "1h"
  no_parent       = true
  renew_min_lease = 21600
  renew_increment = 21600
}
