# Define variables for the Azure VM module
variable "resource_group_name" {
    type = string
    description = "The name of the resource group in which to create the VM"
    default = "rg-azure-vm"
}

variable "location" {
    type = string
    description = "The location of the resource group in which to create the VM"
}

variable "vnet_address_space" {
    type = list(string)
    description = "The address space for the VNET"
    default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
    type = list(string)
    description = "The address prefixes for the subnet"
    default = ["10.0.0.0/24"]
}

variable "vm_size" {
    type = string
    description = "The size of the VM to create"
    default = "Standard_B1s"
}

variable "admin_username" {
    type = string
    description = "The admin username to use for the VM"
    default = "azureuser"
}

variable "tags" {
    type = map(string)
    description = "The tags to apply to all resources"
}

variable "vm_count" {
    type = number
    description = "The number of VMs to create"
    default = 1
}

variable "computer_name" {
    type = string
    description = "The name of the VM to create"
    default = "vm"
}

variable "os_publisher" {
    type = string
    description = "The publisher of the OS image to use for the VM"
    default = "Canonical"
}

variable "os_offer" {
    type = string
    description = "The offer of the OS image to use for the VM"
    default = "UbuntuServer"
}

variable "os_sku" {
    type = string
    description = "The SKU of the OS image to use for the VM"
    default = "18.04-LTS"
}

variable "os_version" {
    type = string
    description = "The version of the OS image to use for the VM"
    default = "latest"
}

variable "environment" {
    type = string
    description = "The environment in which the VM is being created"
    default = "dev"
}
