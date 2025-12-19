terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
    backend "azurerm" {
    resource_group_name = "kv-rg1"
    storage_account_name = "ss145"
    container_name = "ss-infra"
     key = "QA.terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id = "de1c1815-4f90-412b-9551-d55f0de9407d"
}