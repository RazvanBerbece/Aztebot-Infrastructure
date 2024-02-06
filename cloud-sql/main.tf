locals {
  authorized_cidr = ["92.30.245.179"]
}

### SQL Cloud Instance and SQL Users

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
        for_each = local.authorized_cidr
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
  }
}

resource "google_sql_user" "sql_user" {
  name     = var.SQL_USER_NAME
  instance = google_sql_database_instance.main.name
  password = var.SQL_USER_PASS
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