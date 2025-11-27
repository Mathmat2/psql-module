ephemeral "random_password" "root_password" {
    length = 32
    special = true
}

resource "google_secret_manager_secret" "root_password_secret" {
    project = var.project_id
    secret_id = "gsm-${var.name}-root-secret"

    replication {
        user_managed {
            replicas {
                location = var.region
                customer_managed_encryption {
                    kms_key_name = var.kms_key
                }
            }
        }
    }
}

resource "google_secret_manager_secret_version" "root_password_secret_version" {
    secret = google_secret_manager_secret.root_password_secret.id
    
    secret_data_wo          = random_password.root_password.result
    secret_data_wo_version  = 1
}