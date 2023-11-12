locals {
  authorized_cidr = ["92.31.107.120"]
}

resource "google_sql_database_instance" "main" {
  name             = var.sql_database_name
  database_version = var.sql_database_version
  region           = var.sql_database_region

  settings {
    tier = var.sql_database_tier
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network_id

      dynamic "authorized_networks" {
        for_each = local.authorized_cidr
        iterator = authorized_cidr

        content {
          name  = "authorized_cidr-${authorized_cidr.key}"
          value = authorized_cidr.value
        }
      }
    }
  }
}

resource "google_sql_user" "sql_user" {
  name     = var.SQL_USER_NAME
  instance = google_sql_database_instance.main.name
  password = var.SQL_USER_PASS
}