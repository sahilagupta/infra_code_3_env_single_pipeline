
resource "azurerm_mssql_database" "sqldatabase" {
  name         = var.databasemssql
  server_id    = var.server_id
 
  max_size_gb  = var.max_size_gb_database
  sku_name     = var.database_sku_name
  

}