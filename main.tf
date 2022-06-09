data "aws_organizations_organization" "org_root" {}

//all of the OU's within the org
data "aws_organizations_organizational_units" "org_ous" {
  parent_id = data.aws_organizations_organization.org_root.roots[0].id
}

locals {
  non_master_accounts = data.aws_organizations_organization.org_root.non_master_accounts[*]

  # core_ou            = [for ou in data.aws_organizations_organizational_units.org_ous.children : ou if ou.name == "core"][0]
  core_account_names = ["log-archive", "Perimeter", "iam-security", "security", "shared-services", "SharedNetwork", "Operations"]
  core_accounts      = [for account in local.non_master_accounts : account if contains(local.core_account_names, account.name)]

  workload_ou_names = ["Dev", "Test", "Prod", "Tools", "Lab", "Sandbox", "UnClass", "ROSA"]
  workload_ous      = [for ou in data.aws_organizations_organizational_units.org_ous.children : ou if contains(local.workload_ou_names, ou.name)]
  workload_accounts = [for account in local.non_master_accounts : account if !contains(local.core_account_names, account.name)]
}

