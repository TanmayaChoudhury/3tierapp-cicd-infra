terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }

  required_version = ">=1.9.0"
}

provider "azurerm" {
    features {
      
    }
  subscription_id = "85f9051c-3d5f-4da3-bc26-5660c9b51169"
}