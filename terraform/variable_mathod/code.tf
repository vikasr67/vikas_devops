







# Create a resource group
resource "azurerm_resource_group" "prod" {
  name     = var.RG_name
  location = var.RG_location
  
}

resource "azurerm_virtual_network" "prod" {
  name                = var.Vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
}

resource "azurerm_subnet" "prod" {
  name                 = "vikasSubnet"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.prod.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Public IP address
resource "azurerm_public_ip" "prod" {
  name                = "prod-public-ip"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  allocation_method   = "Dynamic"
}


resource "azurerm_network_interface" "prod" {
  name                = "vikasNI"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.prod.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "prod" {
  name = var.VM_name
  resource_group_name = azurerm_resource_group.prod.name
  location = azurerm_resource_group.prod.location
  vm_size = var.VM_size
  network_interface_ids = [azurerm_network_interface.prod.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "Production traffic"
  }
}

# Output the Public IP address of the VM
output "vm_public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.prod.ip_address

}

output "tags" {
  value = azurerm_virtual_machine.prod.name
  
}



