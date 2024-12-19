# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=3.0.0"
#     }
#   }
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"  # You can specify a version if needed
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"  # Specify a version if needed
    }
  }
}

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.0.0"  # Example of specifying a version
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = "3.0.0"  # Example of specifying a version
#     }
#   }
# }


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}  # This is the required block
}


# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0"  # Adjust the version to match your needs
#     }
#   }
# }

