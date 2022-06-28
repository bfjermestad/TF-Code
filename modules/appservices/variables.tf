variable "app_azure_rgname" {
  description = "The name of the module demo resource group in which the resources will be created"
  type        = string
  default     = "myResourceGroup-bfjdefault-rg"
}

variable "app_location" {
  description = "The location where module demo resource group will be created"
  type        = string
  default     = "norwayeast"
}


variable "app_appname" {
  description = "The name of the module demo resource group in which the resources will be created"
  type        = string
  default     = "bfjnodeapp-default"
}