resource "google_sql_database_instance" "main" {
  name             = var.sql_database_name
  database_version = var.sql_database_version
  region           = var.sql_database_region

  settings {
    tier = var.sql_database_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network_id
    }
  }
}

resource "google_sql_user" "sql_user" {
  name     = var.SQL_USER_NAME
  instance = google_sql_database_instance.main.name
  password = var.SQL_USER_PASS
}