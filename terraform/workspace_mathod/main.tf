
# Variables for resource names, locations, and VM configurations
variable "RG_name" {
  type    = map(string)

  default = {
    "dev" = "vikasdev"
    "stage" = "vikasstage"
    "prod" = "vikasprod"
  }
  
}
# variable "RG_location" {
#   type    = string
#   default = "South India"
# }

variable "RG_location" {
    description = "Infra region depends on it"
    type = map(string)

    default = {
      "dev" = "South India"
      "stage" = "East Asia"
      "prod" = "japan East"
    }
  
}

variable "Vnet_name" {
  type    = string
  
}

variable "VM_name" {
  type    = string
  
}

variable "VM_size" {
  type    = string
  
}

variable "nic_name" {
  type = string
  default = "newnic"
  
}



# Create a resource group
resource "azurerm_resource_group" "prod" {
  name     = lookup(var.RG_name, terraform.workspace, "error")
  location = lookup(var.RG_location, terraform.workspace, "South India")
}
# Create a virtual network
resource "azurerm_virtual_network" "prod" {
  name                = var.Vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
}
# Create a subnet within the virtual network
resource "azurerm_subnet" "prod" {
  name                 = "vikasSubnet"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.prod.name
  address_prefixes     = ["10.0.2.0/24"]
}
# create public iP address , later required to assign to network interface
resource "azurerm_public_ip" "prod" {
  count               = 3  # Create 3 public IP addresses
  name                = "prod-public-ip-${count.index + 1}"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  allocation_method   = "Dynamic"
}
# Create a network interface for the VM
resource "azurerm_network_interface" "prod" {
  count = 3
  name                = "${var.nic_name}-${count.index + 1}"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.prod.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.prod[count.index].id
  }
}
# Create a Network Security Group (NSG) to allow SSH access and HTTP access
resource "azurerm_network_security_group" "prod" {
  name                = "prod-nsg"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  security_rule {
    name                       = "SSH-Allow"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP-Allow"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Attach NSG to the VM's network interface
resource "azurerm_network_interface_security_group_association" "prod" {
  count                  = length(azurerm_network_interface.prod)
  network_interface_id      = azurerm_network_interface.prod[count.index].id 
  network_security_group_id = azurerm_network_security_group.prod.id
}
resource "random_id" "os_disk_id" {
  count      = 3    # One random ID for each VM
  byte_length = 8   # Generates a random ID of 8 bytes
}

resource "azurerm_virtual_machine" "prod" {
  count = 3
  name                   = "myvm-${count.index + 1}"
  resource_group_name    = azurerm_resource_group.prod.name
  location               = azurerm_resource_group.prod.location
  vm_size                = var.VM_size
  network_interface_ids  = [azurerm_network_interface.prod[count.index].id]
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    # Create a unique disk name for each VM using the random ID with count.index
    name              = "myosdisk-${random_id.os_disk_id[count.index].hex}"  # Unique disk name for each VM
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
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/testadmin/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }
}


