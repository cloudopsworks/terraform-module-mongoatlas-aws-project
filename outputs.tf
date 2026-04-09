##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "project_name" {
  value = module.project.project_name
}

output "project_id" {
  value = module.project.project_id
}

output "project_creation_timestamp" {
  value = module.project.project_creation_timestamp
}

output "project_backup_policy_id" {
  value = module.project.project_backup_policy_id
}

output "project_kms_iam_role_name" {
  value = try(var.settings.encryption_at_rest.enabled, false) ? aws_iam_role.kms[0].name : null
}

output "project_kms_iam_role_arn" {
  value = try(var.settings.encryption_at_rest.enabled, false) ? aws_iam_role.kms[0].arn : null
}

output "project_kms_key_id" {
  value = try(var.settings.encryption_at_rest.enabled, false) ? aws_kms_key.kms[0].id : null
}

output "project_kms_key_arn" {
  value = try(var.settings.encryption_at_rest.enabled, false) ? aws_kms_key.kms[0].arn : null
}

output "project_kms_key_alias" {
  value = try(var.settings.encryption_at_rest.enabled, false) ? aws_kms_alias.kms[0].name : null
}

output "imported_alert_statement" {
  value = module.project.imported_alert_statement
}

output "imported_alert_json" {
  value = module.project.imported_alert_json
}

output "imported_kms_alert_statement" {
  value = var.generate_import ? (
    length(local.kms_alert_import) > 0 ? join("\n", local.kms_alert_import) : null
  ) : null
}
