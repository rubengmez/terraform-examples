terraform {
  required_version = ">=0.13.5"
}

provider "azurerm" {
    version = "=2.37.0"
    features {}
}

resource "azurerm_resource_group" "terraform-testing" {
    name = "terraform-testing"
    location = var.location
}