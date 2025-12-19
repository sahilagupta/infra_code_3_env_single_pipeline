variable "mssql_server_name" {}
variable "resource_group_name" {}

variable "location" {}
variable "administrator_login" {}
variable "administrator_login_password" {
  type = string
  sensitive = true
}
variable "sql_version" {}
variable "minimum_tls_version" {}