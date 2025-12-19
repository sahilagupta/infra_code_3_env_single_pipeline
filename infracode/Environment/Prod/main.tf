module "resource_group" {
  source = "../../Child_module/azurerm_resource_group"
  rgs    = var.rgs
}

module "networking" {
  depends_on = [module.resource_group]
  source     = "../../Child_module/azurerm_networking"
  vnets      = var.vnets

}

module "publicIP" {
  depends_on = [module.resource_group]
  source     = "../../Child_module/azurerm_public_ip"
  pips       = var.pips
}

# module "keyvault" {
#   depends_on = [module.resource_group]
#   source     = "../../Child_module/key_vault"
#   kvs        = var.kvs
# }

module "compute" {
  depends_on = [module.resource_group, module.networking, module.publicIP]
  source     = "../../Child_module/azurerm_compute"
  vms        = var.vms
  nsg_ids    = module.nsg.nsg_ids
}

module "sql_server" {
  depends_on                   = [module.resource_group]
  source                       = "../../Child_module/azurerm_sql_server"
  mssql_server_name            = "todo24server24"
  location                     = "centralus"
  administrator_login          = "Student"
  administrator_login_password = "My@Sql2024#Pass"
  sql_version                  = "12.0"
  minimum_tls_version          = "1.2"
  resource_group_name          = "todo-rg1"
}

module "sql_database" {
  source               = "../../Child_module/azurerm_sql_database"
  databasemssql        = "todo24database"
  max_size_gb_database = 2
  database_sku_name    = "S0"
  server_id            = module.sql_server.ms_serverid

}
module "nsg" {
  source     = "../../Child_module/azurerm_nsg"
  depends_on = [module.resource_group]
  nsgs       = var.nsgs

}



