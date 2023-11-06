variable "sql_database_name" {
  description = "Name of the SQL Cloud instance in Google Cloud"
  type        = string
}

variable "sql_database_version" {
  description = "Version of the SQL Cloud instance in Google Cloud (e.g. MYSQL_5_7, MYSQL_8_0, SQLSERVER_2017_STANDARD, etc.)"
  type        = string
}

variable "sql_database_region" {
  description = "Region for the SQL Cloud instance in Google Cloud"
  type        = string
}

variable "sql_database_tier" {
  description = "Tier for the SQL Cloud instance in Google Cloud"
  type        = string
}
