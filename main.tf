##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "project" {
  source = "../terraform-module-mongoatlas-project"

  is_hub     = var.is_hub
  spoke_def  = var.spoke_def
  org        = var.org
  extra_tags = var.extra_tags

  name_prefix       = var.name_prefix
  name              = var.name
  organization_name = var.organization_name
  organization_id   = var.organization_id
  settings = merge(var.settings, {
    excluded_alert_event_types = concat(
      try(var.settings.excluded_alert_event_types, []),
      try(var.settings.encryption_at_rest.enabled, false) ? ["AWS_ENCRYPTION_KEY_NEEDS_ROTATION"] : []
    )
  })
  generate_import     = var.generate_import
  encryption_provider = try(var.settings.encryption_at_rest.enabled, false) ? "AWS" : ""
  encryption_provider_config = {
    iam_assumed_role_arn   = try(aws_iam_role.kms[0].arn, null)
    customer_master_key_id = try(aws_kms_key.kms[0].arn, null)
    region                 = local.atlas_region
  }
}

resource "mongodbatlas_alert_configuration" "kms_alert" {
  count      = try(var.settings.encryption_at_rest.enabled, false) ? 1 : 0
  project_id = module.project.project_id
  event_type = "AWS_ENCRYPTION_KEY_NEEDS_ROTATION"
  enabled    = false
  notification {
    type_name     = "GROUP"
    interval_min  = 60
    delay_min     = 0
    email_enabled = true
    roles         = ["GROUP_OWNER"]
  }
  threshold_config {
    operator  = "GREATER_THAN"
    threshold = 90
    units     = "DAYS"
  }
}
