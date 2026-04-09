##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  kms_alert_import = [
    for alert in module.project.all_alert_configurations :
    "import 'mongodbatlas_alert_configuration.kms_alert[0]' '${alert.project_id}-${alert.alert_configuration_id}'"
    if alert.event_type == "AWS_ENCRYPTION_KEY_NEEDS_ROTATION"
  ]
}
