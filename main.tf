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
      name = "learn-terraform-azure"
    }
  }

}
provider "azurerm" {
  features {}
}