variable "sql_database_instance_name" {
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

variable "private_network_id" {
  description = "ID of the private network that the SQL Cloud instance resides in"
  type        = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "db_manager_sa_email" {
  description = "SA DB Manager email address"
  type        = string
}

variable "sql_user_name" {
  description = "SQL user name"
  type        = string
  sensitive   = true
  default     = "aztebotservice"
}

variable "sql_authorised_cidr" {
  type        = list(string)
  description = "IPv4 CIDRs to allow to connect to the DB publicly"
}