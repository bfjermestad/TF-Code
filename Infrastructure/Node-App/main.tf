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
    location = "norwayeast"
  }
}
# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}
# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-${random_integer.ri.result}"
}

# Create the Linux App Service Plan from module
module "appserviceplan" {
source = "git::https://github.com/bfjermestad/tf-code/modules/appservices/main.tf"
azure_rg_name = var.azure_rg_name
location = var.location
}

# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  #name                = "webapp-${random_integer.ri.result}"
  name                = "bfjnodeapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  source_control {
    repo_url           = "https://github.com/bfjermestad/nodeapp"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}
