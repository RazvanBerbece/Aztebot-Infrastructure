resource "google_sql_database_instance" "main" {
  name             = "aztebot-bot-db" // var.sql_database_name
  database_version = "MYSQL_5_7"      // var.sql_database_version
  region           = "europe-west2"   // var.sql_database_region

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro" // var.sql_database_tier
  }
}