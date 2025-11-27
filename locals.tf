locals {
  activation_policy              = "ALWAYS"
  availibility_type              = "REGIONAL"
  point_in_time_recovery_enabled = local.availibility_type == "REGIONAL" ? true : false

  # Backup configuration
  backup_configurations = {
    enabled                        = true
    start_time                     = "23:00"
    retention_unit                 = "COUNT"
    retained_backups               = 3
    transaction_log_retention_days = 7
  }

  connector_enforcement = var.cloud_sql_auth_proxy_usage ? "REQUIRED" : "NOT_REQUIRED"

  disk_autoresize = var.max_disk_size > 0 ? true : false

  # Maintenance window configuration
  maintenance_window_day          = 1
  maintenance_window_hour         = 23
  maintenance_window_update_track = "canary"
}