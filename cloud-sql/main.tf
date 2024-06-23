resource "random_password" "sql_user_password" {
  length  = 16
  special = true
}

resource "google_sql_database_instance" "main" {
  name             = var.sql_database_instance_name
  database_version = var.sql_database_version
  region           = var.sql_database_region

  settings {
    tier = var.sql_database_tier
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network_id

      // Allow these external networks to connect to the DB
      dynamic "authorized_networks" {
        for_each = var.sql_authorised_cidr
        iterator = authorized_cidr

        content {
          name  = "authorized_cidr-${authorized_cidr.key}"
          value = authorized_cidr.value
        }
      }
    }

    database_flags {
      name  = "cloudsql_iam_authentication"
      value = "on"
    }

    backup_configuration {
      enabled    = true
      location   = var.sql_database_region
      start_time = "02:00"

      backup_retention_settings {
        retained_backups = 1
      }
    }
  }
}

resource "google_sql_user" "sql_user" {
  name     = var.sql_user_name
  instance = google_sql_database_instance.main.name
  password = random_password.sql_user_password.result
}

resource "google_sql_user" "iam_db_manager_service_account_user" {
  name     = var.db_manager_sa_email
  instance = google_sql_database_instance.main.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

### Databases
resource "google_sql_database" "aztebot-bot-db" {
  name     = "aztebotBotDb"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_database" "aztemarket-db" {
  name     = "azteMarketDb"
  instance = google_sql_database_instance.main.name
}
