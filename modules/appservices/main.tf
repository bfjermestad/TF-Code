

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}


# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-asp-bfjappplan"
  location            = var.app_location
  resource_group_name = var.app_azure_rgname
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = var.app_appname
  location            = var.app_location
  resource_group_name = var.app_azure_rgname
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  source_control {
    repo_url           = "https://github.com/bfjermestad/nodeapp"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}
