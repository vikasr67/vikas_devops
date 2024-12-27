variable "RG_name" {
  type = string
  default = "Docker"
}

variable "RG_location" {
  type = string
  default = "South India"
}

variable "Vnet_name" {
  type = string
  default = "VikasVNet"
}

variable "VM_name" {
  type = string
  default = "DockerVM"
}

variable "VM_size" {
  type = string
  default = "Standard_B1s"
}