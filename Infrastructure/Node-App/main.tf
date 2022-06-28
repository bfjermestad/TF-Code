# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"

cloud {
    organization = "Fjermestad"
    workspaces {
      name = "TF-Code"
    }
  }

}

provider "azurerm" {
  features {
  }
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-BFJNODEAPP"
}

# Create the Linux App Service Plan from module
module "appserviceplan" {
source = "git::https://github.com/bfjermestad/tf-code//modules/appservices"
azure_rg_name = azurerm_resource_group.rg.name
location = "norwayeast"
appname = "bfjnodeapp"
}
