##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  description = "Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the resource"
  type        = string
  default     = ""
}

variable "organization_name" {
  description = "(optional) The name of the organization where the project will be created"
  type        = string
  default     = ""
}

variable "organization_id" {
  description = "(optional) The ID of the organization where the project will be created"
  type        = string
  default     = ""
}

## Settings YAML format:
# settings:
#   default_alerts_settings: true | false
#   collect_database_specifics_statistics_enabled: true | false
#   data_explorer_enabled: true | false
#   extended_storage_sizes_enabled: true | false
#   performance_advisor_enabled: true | false
#   schema_advisor_enabled: true | false
#   backup_compliance:
#     enabled: true | false  (default: false)
#     authorized_user:
#       email: string
#       first_name: string
#       last_name: string
#     copy_protection_enabled: true | false (default: false)
#     pit_enabled: true | false (default: false)
#     encryption_at_rest_enabled: true | false (default: false)
#     restore_window_days: number (default: 7)
#     hourly:
#       interval: number (default: 1)
#       retention_unit: string (default: "days")
#       retention_value: number (default: 1)
#     daily:
#       interval: number (default: 1)
#       retention_unit: string (default: "days")
#       retention_value: number (default: 7)
#     weekly:
#       interval: number (default: 1)
#       retention_unit: string (default: "weeks")
#       retention_value: number (default: 4)
#     monthly:
#       interval: number (default: 1)
#       retention_unit: string (default: "months")
#       retention_value: number (default: 12)
#     yearly:
#       interval: number (default: 1)
#       retention_unit: string (default: "years")
#       retention_value: number (default: 2)
#     on_demand:
#       interval: number (default: 1)
#       retention_unit: string (default: "days")
#       retention_value: number (default: 7)
#  maintenance:
#    enabled: true | false (default: false)
#    day_of_week: string (default: 1 "Sunday")
#    hour_of_day: number (default: 0)
#    start_asap: true | false (default: null)
#    defer: true | false (default: null)
#    auto_defer: true | false (default: null)
#    auto_defer_once_enabled: true | false (default: null)
#  access_list:
#   <id>:
#     comment: string (optional, item comment)
#     ip_address: string (optional, conflicts with aws_security_group & cidr_block)
#     aws_security_group: string (optional, conflicts with ip_address & cidr_block)
#     cidr_block: string (optional, conflicts with ip_address & aws_security_group)
# encryption_at_rest:
#   enabled: true | false (default: false)
#   deletion_window_in_days: number (default: 7)
#   enable_key_rotation: true | false (default: true)
#   rotation_period_in_days: number (default: 90)
#   multi_region: true | false (default: false)
# alerts:
#   - event_type: "string" # Name of the alert configuration  - https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-createalertconfiguration
#     enabled: true | false # (default: true)
#     notifications:
#       - type_name: "string" # Notification type name - https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-createalertconfiguration
#         roles: ["string"] # Roles - https://www.mongodb.com/docs/api/doc/atlas-admin-api-v2/operation/operation-createalertconfiguration
#         api_token: "string" # (optional) Slack API token. Required for the SLACK notifications type. If the token later becomes invalid, Atlas sends an email to the project owner and eventually removes the token
#         channel_name: "string" # (optional) Slack channel name. Required for the SLACK notifications type
#         datadog_api_key: "string" # (optional) Datadog API key. Required for the DATADOG notifications type
#         datadog_region: "string" # (optional) Datadog region. Required for the DATADOG notifications type
#         delay_min: number # (optional) The delay, in minutes, between the time the alert condition is met and the time Atlas sends the alert notification
#         email_address: "string" # (optional) Email address. Required for the EMAIL notifications type
#         email_enabled: true | false # (optional) Flag that indicates whether to send email notifications to the project owner. Required for the PROJECT_OWNER notifications type
#         interval_min: number # (optional) The interval, in minutes, at which Atlas repeats the alert notification while the alert condition persists.
#         mobile_number: "string" # (optional) Mobile number. Required for the SMS notifications type
#         ops_genie_api_key: "string" # (optional) OpsGenie API key. Required for the OPS_GENIE notifications type
#         ops_genie_region: "string" # (optional) OpsGenie region.
#         service_key: "string" # (optional) Service key. Required for the PAGER_DUTY notifications type
#         sms_enabled: true | false # (optional) Flag that indicates whether to send SMS notifications to the project owner. Required for the PROJECT_OWNER notifications type
#         team_id: "string" # (optional) The ID of the team that receives the alert notification. Required for the TEAMS notifications type
#         team_name: "string" # (optional) The name of the team that receives the alert notification. Required for the TEAMS notifications type
#         integration_id: "string" # (optional) The ID of the third-party integration that notifies the team. Required for the TEAMS notifications type
#         notifier_id: "string" # (optional) The ID of the third-party integration that notifies the team. Required for the TEAMS notifications type
#         username: "string" # (optional) Username for Atlas number.
#         victor_ops_api_key: "string" # (optional) VictorOps API key. Required for the VICTOR_OPS notifications type
#         victor_ops_routing_key: "string" # (optional) VictorOps routing key
#         webhook_secret: "string" # (optional) Webhook secret. Required for the WEBHOOK notifications type
#         webhook_url: "string" # (optional) Webhook URL. Required for the WEBHOOK notifications type
#         microsoft_teams_webhook_url: "string" # (optional) Microsoft Teams webhook URL. Required for the MICROSOFT_TEAMS notifications type
#     matchers:
#       - field_name: "string" # (optional) Field name
#         operator: "string" # (optional) Operator
#         value: "string" # (optional) Value
#     metric_threshold_config:
#       metric_name: "string" # (optional) Metric name
#       operator: "string" # (optional) Operator
#       threshold: number # (optional) Threshold
#       units: "string" # (optional) Units
#       mode: "string" # (optional) Mode
#     metric_threshold:
#       operator: "string" # (optional) Operator
#       threshold: number # (optional) Threshold
#       units: "string" # (optional) Units
variable "settings" {
  description = "(optional) The backup compliance policy"
  type        = any
  default     = {}
}

variable "generate_import" {
  description = "Generate import statements"
  type        = bool
  default     = false
}