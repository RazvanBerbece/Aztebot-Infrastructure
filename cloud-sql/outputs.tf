output "connection_name" {
  value = google_sql_database_instance.main.connection_name
}

output "sql_user_password" {
  value = random_password.sql_user_password
  sensitive = true
}