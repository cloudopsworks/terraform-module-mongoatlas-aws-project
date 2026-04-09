##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
# Migration blocks: resources moved from root module to module.project submodule.
# These blocks allow existing state to be automatically migrated when upgrading
# from a prior version of this module that managed Atlas resources directly.
#

moved {
  from = mongodbatlas_project.this
  to   = module.project.mongodbatlas_project.this
}

moved {
  from = mongodbatlas_backup_compliance_policy.this
  to   = module.project.mongodbatlas_backup_compliance_policy.this
}

moved {
  from = mongodbatlas_maintenance_window.this
  to   = module.project.mongodbatlas_maintenance_window.this
}

moved {
  from = mongodbatlas_project_ip_access_list.this
  to   = module.project.mongodbatlas_project_ip_access_list.this
}

moved {
  from = mongodbatlas_alert_configuration.alert
  to   = module.project.mongodbatlas_alert_configuration.alert
}

moved {
  from = mongodbatlas_cloud_provider_access_setup.this
  to   = module.project.mongodbatlas_cloud_provider_access_setup.this
}

moved {
  from = mongodbatlas_cloud_provider_access_authorization.this
  to   = module.project.mongodbatlas_cloud_provider_access_authorization.this
}

moved {
  from = mongodbatlas_encryption_at_rest.this
  to   = module.project.mongodbatlas_encryption_at_rest.this
}
