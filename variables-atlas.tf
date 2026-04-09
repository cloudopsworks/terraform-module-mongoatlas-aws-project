##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  # (Optional) Prefix prepended to the auto-generated project name when `name` is not set. Default: "".
  description = "(Optional) Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "name" {
  # (Optional) Explicit name for the MongoDB Atlas project. When set, overrides `name_prefix`. Default: "".
  description = "(Optional) Explicit name for the MongoDB Atlas project; overrides name_prefix"
  type        = string
  default     = ""
}

variable "organization_name" {
  # (Optional) Name of the MongoDB Atlas organization. Used to look up the org ID when `organization_id` is not provided.
  description = "(Optional) The name of the MongoDB Atlas organization where the project will be created"
  type        = string
  default     = ""
}

variable "organization_id" {
  # (Optional) Direct MongoDB Atlas organization ID. Takes precedence over `organization_name` lookup.
  description = "(Optional) The ID of the MongoDB Atlas organization where the project will be created"
  type        = string
  default     = ""
}

## Settings object structure (all keys are optional unless noted):
#
# settings:
#   default_alerts_settings: true | false          # (Optional) Enable default alert settings for the project.
#   collect_database_specifics_statistics_enabled: true | false  # (Optional) Collect database-specific statistics.
#   data_explorer_enabled: true | false            # (Optional) Enable Data Explorer.
#   extended_storage_sizes_enabled: true | false   # (Optional) Enable extended storage sizes.
#   performance_advisor_enabled: true | false      # (Optional) Enable Performance Advisor.
#   schema_advisor_enabled: true | false           # (Optional) Enable Schema Advisor.
#
#   backup_compliance:
#     enabled: true | false                        # (Optional) Enable backup compliance policy. Default: false.
#     authorized_user:
#       email: string                              # (Required) Email of the authorized user.
#       first_name: string                         # (Required) First name of the authorized user.
#       last_name: string                          # (Required) Last name of the authorized user.
#     copy_protection_enabled: true | false        # (Optional) Enable copy protection. Default: false.
#     pit_enabled: true | false                    # (Optional) Enable Point-in-Time recovery. Default: false.
#     encryption_at_rest_enabled: true | false     # (Optional) Require encryption at rest. Default: false.
#     restore_window_days: number                  # (Optional) Restore window in days. Default: 7.
#     hourly:
#       interval: number                           # (Optional) Frequency interval (hours). Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "days". Default: "days".
#       retention_value: number                    # (Optional) Retention value. Default: 1.
#     daily:
#       interval: number                           # (Optional) Frequency interval (days). Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "days". Default: "days".
#       retention_value: number                    # (Optional) Retention value. Default: 7.
#     weekly:
#       interval: number                           # (Optional) Day of week (1=Sunday … 7=Saturday). Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "weeks". Default: "weeks".
#       retention_value: number                    # (Optional) Retention value. Default: 4.
#     monthly:
#       interval: number                           # (Optional) Day of month (1–28). Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "months". Default: "months".
#       retention_value: number                    # (Optional) Retention value. Default: 12.
#     yearly:
#       interval: number                           # (Optional) Month of year (1–12). Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "years". Default: "years".
#       retention_value: number                    # (Optional) Retention value. Default: 2.
#     on_demand:
#       interval: number                           # (Optional) Must be 0. Default: 1.
#       retention_unit: string                     # (Optional) Retention unit. Values: "days". Default: "days".
#       retention_value: number                    # (Optional) Retention value. Default: 7.
#
#   maintenance:
#     enabled: true | false                        # (Optional) Enable maintenance window. Default: false.
#     day_of_week: number                          # (Optional) Day of week (1=Sunday … 7=Saturday). Default: 1.
#     hour_of_day: number                          # (Optional) Hour of day in UTC (0–23). Default: 0.
#     defer: true | false                          # (Optional) Defer the next scheduled maintenance. Default: null.
#     auto_defer: true | false                     # (Optional) Auto-defer maintenance. Default: null.
#     auto_defer_once_enabled: true | false        # (Optional) Enable auto-defer once. Default: null.
#
#   access_list:                                   # (Optional) Map of IP access list entries keyed by a unique ID.
#     <id>:
#       comment: string                            # (Optional) Human-readable comment for the entry.
#       ip_address: string                         # (Optional) Single IP address. Conflicts with cidr_block and aws_security_group.
#       aws_security_group: string                 # (Optional) AWS security group ID. Conflicts with ip_address and cidr_block.
#       cidr_block: string                         # (Optional) CIDR block. Conflicts with ip_address and aws_security_group.
#
#   encryption_at_rest:
#     enabled: true | false                        # (Optional) Enable AWS KMS encryption at rest. Default: false.
#     deletion_window_in_days: number              # (Optional) KMS key deletion window (7–30 days). Default: 7.
#     enable_key_rotation: true | false            # (Optional) Enable automatic KMS key rotation. Default: true.
#     rotation_period_in_days: number              # (Optional) Key rotation period in days (90–2560). Default: 90.
#     multi_region: true | false                   # (Optional) Create a multi-region KMS key. Default: false.
#
#   alerts:                                        # (Optional) List of alert configurations.
#     - event_type: string                         # (Required) Atlas event type. See https://www.mongodb.com/docs/atlas/reference/api-resources-spec/v2/#tag/Alert-Configurations/operation/createAlertConfiguration
#       enabled: true | false                      # (Optional) Enable this alert. Default: true.
#       notifications:
#         - type_name: string                      # (Required) Notification type. Values: EMAIL, SMS, GROUP, ORG, TEAM, SLACK, DATADOG, OPS_GENIE, VICTOR_OPS, WEBHOOK, MICROSOFT_TEAMS, PAGER_DUTY.
#           roles: ["string"]                      # (Optional) Project roles to notify. Values: GROUP_OWNER, GROUP_READ_ONLY, etc.
#           api_token: string                      # (Optional) Slack API token. Required for SLACK type.
#           channel_name: string                   # (Optional) Slack channel name. Required for SLACK type.
#           datadog_api_key: string                # (Optional) Datadog API key. Required for DATADOG type.
#           datadog_region: string                 # (Optional) Datadog region. Values: "US", "EU". Required for DATADOG type.
#           delay_min: number                      # (Optional) Delay in minutes before sending notification.
#           email_address: string                  # (Optional) Email address. Required for EMAIL type.
#           email_enabled: true | false            # (Optional) Send email to project owner. Required for PROJECT_OWNER type.
#           interval_min: number                   # (Optional) Re-notification interval in minutes.
#           mobile_number: string                  # (Optional) Mobile number. Required for SMS type.
#           ops_genie_api_key: string              # (Optional) OpsGenie API key. Required for OPS_GENIE type.
#           ops_genie_region: string               # (Optional) OpsGenie region. Values: "US", "EU".
#           service_key: string                    # (Optional) PagerDuty service key. Required for PAGER_DUTY type.
#           sms_enabled: true | false              # (Optional) Send SMS to project owner. Required for PROJECT_OWNER type.
#           team_id: string                        # (Optional) Team ID to notify. Required for TEAMS type.
#           team_name: string                      # (Optional) Team name. Required for TEAMS type.
#           integration_id: string                 # (Optional) Third-party integration ID.
#           notifier_id: string                    # (Optional) Notifier ID.
#           username: string                       # (Optional) Atlas username for USER type.
#           victor_ops_api_key: string             # (Optional) VictorOps API key. Required for VICTOR_OPS type.
#           victor_ops_routing_key: string         # (Optional) VictorOps routing key.
#           webhook_secret: string                 # (Optional) Webhook HMAC secret. Required for WEBHOOK type.
#           webhook_url: string                    # (Optional) Webhook URL. Required for WEBHOOK type.
#           microsoft_teams_webhook_url: string    # (Optional) Microsoft Teams webhook URL. Required for MICROSOFT_TEAMS type.
#       matchers:
#         - field_name: string                     # (Optional) Field to match. Values: TYPE_NAME, HOSTNAME, PORT, HOSTNAME_AND_PORT, REPLICA_SET_NAME, SHARD_NAME, CLUSTER_NAME.
#           operator: string                       # (Optional) Comparison operator. Values: EQUALS, NOT_EQUALS, CONTAINS, NOT_CONTAINS, STARTS_WITH, ENDS_WITH, REGEX.
#           value: string                          # (Optional) Value to match against.
#       metric_threshold_config:
#         metric_name: string                      # (Optional) Atlas metric name.
#         operator: string                         # (Optional) Comparison operator. Values: GREATER_THAN, LESS_THAN.
#         threshold: number                        # (Optional) Numeric threshold value.
#         units: string                            # (Optional) Metric units (e.g., "DAYS", "HOURS", "MEGABYTES").
#         mode: string                             # (Optional) Aggregation mode. Values: AVERAGE, TOTAL, MAXIMUM, MINIMUM.
#       threshold_config:
#         operator: string                         # (Optional) Comparison operator. Values: GREATER_THAN, LESS_THAN.
#         threshold: number                        # (Optional) Numeric threshold value.
#         units: string                            # (Optional) Threshold units.
variable "settings" {
  description = "(Optional) Module settings object controlling project features: backup compliance, maintenance window, IP access list, encryption at rest, and alert configurations"
  type        = any
  default     = {}
}

variable "generate_import" {
  # (Optional) When true, generates import blocks for existing Atlas resources. Default: false.
  description = "(Optional) Generate OpenTofu import blocks for existing Atlas resources"
  type        = bool
  default     = false
}