resource "random_id" "unique_id" {
  provider    = random
  byte_length = 2
}

resource "google_sql_database_instance" "sql_instance" {
  provider = google
  project  = var.project_id
  region   = var.region

  name = "db-${var.name}-${random_id.unique_id.hex}"

  database_version = var.database_version

  encryption_key_name = var.kms_key
  root_password       = random_password.root_password.result

  settings {
    tier = var.database_tier

    activation_policy           = local.activation_policy
    availability_type           = local.availibility_type
    deletion_protection_enabled = var.deletion_protection
    connector_enforcement       = local.connector_enforcement

    dynamic "backup_configuration" {
      for_each = [local.backup_configurations]
      content {
        enabled                        = lookup(backup_configuration.value, "enabled", false)
        start_time                     = lookup(backup_configuration.value, "start_time", null)
        location                       = lookup(backup_configuration.value, "location", null)
        point_in_time_recovery_enabled = local.point_in_time_recovery_enabled
        transaction_log_retention_days = lookup(backup_configuration.value, "transaction_log_retention_days", null)

        backup_retention_settings {
          retained_backups = lookup(backup_configuration.value, "retained_backups", null)
          retention_unit   = lookup(backup_configuration.value, "retention_unit", null)
        }
      }
    }

    ip_configuration {
      ipv4_enabled                                  = false
      enable_private_path_for_google_cloud_services = true
      private_network                               = data.google_compute_network.vpc.self_link
    }

    disk_autoresize       = local.disk_autoresize
    disk_autoresize_limit = local.disk_autoresize ? var.max_disk_size : null

    maintenance_window {
      day          = local.maintenance_window_day
      hour         = local.maintenance_window_hour
      update_track = local.maintenance_window_update_track
    }
  }
}