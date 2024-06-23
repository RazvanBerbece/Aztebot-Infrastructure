variable "sql_authorised_cidr" {
  type        = list(string)
  description = "IPv4 CIDRs to allow to connect to the DB publicly"
}