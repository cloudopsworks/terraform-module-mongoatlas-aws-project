##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

locals {
  format_alerts = data.mongodbatlas_alert_configurations.import.results
  import_statements = compact(concat([
    for i, alert in local.format_alerts :
    "import 'mongodbatlas_alert_configuration.alert[\"${alert.event_type}\"]' '${alert.project_id}-${alert.alert_configuration_id}'"
    if alert.event_type != "AWS_ENCRYPTION_KEY_NEEDS_ROTATION"
    ], [
    for i, alert in local.format_alerts :
    "import 'mongodbatlas_alert_configuration.kms_alert[0]' '${alert.project_id}-${alert.alert_configuration_id}'"
    if alert.event_type == "AWS_ENCRYPTION_KEY_NEEDS_ROTATION"
  ]))
  alert_yaml = {
    alerts = [
      for i, alert in local.format_alerts : {
        event_type = alert.event_type
        enabled    = alert.enabled
        notifications = [
          for n in alert.notification : {
            type_name           = n.type_name
            interval_min        = try(n.interval_min, null)
            delay_min           = try(n.delay_min, null)
            email_address       = try(n.email_address, null)
            sms_number          = try(n.sms_number, null)
            mobile_device_token = try(n.mobile_device_token, null)
            team_id             = try(n.team_id, null)
            api_token           = try(n.api_token, null)
            url                 = try(n.url, null)
            username            = try(n.username, null)
            password            = try(n.password, null)
            auth_type           = try(n.auth_type, null)
            headers             = try(n.headers, null)
          }
        ]
        matchers = [
          for m in alert.matcher : {
            field_name = m.field_name
            operator   = m.operator
            value      = m.value
          }
        ]
        metric_threshold_config = length(try(alert.metric_threshold_config, [])) > 0 ? {
          metric_name = alert.metric_threshold_config[0].metric_name
          operator    = alert.metric_threshold_config[0].operator
          threshold   = alert.metric_threshold_config[0].threshold
          units       = alert.metric_threshold_config[0].units
          mode        = alert.metric_threshold_config[0].mode
        } : null
        threshold_config = length(try(alert.threshold_config, [])) > 0 ? {
          operator  = alert.threshold_config[0].operator
          threshold = alert.threshold_config[0].threshold
          units     = alert.threshold_config[0].units
        } : null
      } if alert.event_type != "AWS_ENCRYPTION_KEY_NEEDS_ROTATION"
    ]
  }
}

data "mongodbatlas_alert_configurations" "import" {
  project_id = mongodbatlas_project.this.id
}

output "imported_alert_statement" {
  value = var.generate_import ? join("\n", local.import_statements) : null
}

output "imported_alert_json" {
  value = var.generate_import ? nonsensitive(jsonencode(local.alert_yaml)) : null
}