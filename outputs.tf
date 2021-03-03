output "root" {
	value = data.aws_organizations_organization.org_root
}

output "master_account" {
	value = {
		"id" = data.aws_organizations_organization.org_root.master_account_id
		"email" = data.aws_organizations_organization.org_root.master_account_email
	}
}

output "core_ou" {
	value = local.core_ou
}

output "core_accounts" {
	value = local.core_accounts
}

output "workload_ous" {
	value = local.workload_ous
}

output "workload_accounts" {
	value = local.workload_accounts
}
