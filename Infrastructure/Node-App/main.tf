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
  location = "norwayeast"
}

# Create the Linux App Service Plan from module
module "myappserviceplan" {
  source           = "git::https://github.com/bfjermestad/tf-code//modules/appservices"
  app_location     = "norway east"
  app_azure_rgname = "myResourceGroup-BFJNODEAPP"
  app_appname      = "bfjnodeapp"
}
