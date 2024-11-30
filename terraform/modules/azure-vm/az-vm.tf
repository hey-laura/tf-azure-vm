# Azure Provider documentation at https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# Configure Azure provider
provider "azurerm" {
    features{}
}

data "azurerm_subscription" "current" {
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
    name        = var.resource_group_name
    location    = var.location
}

# Create VNET
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.environment}-vnet"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    address_space       = var.vnet_address_space
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${var.environment}-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.subnet_address_prefixes
}

# Create Network Interface
resource "azurerm_network_interface" "nic" {
    count                     = var.vm_count
    name                      = "${var.environment}-nic-${count.index + 1}"
    location                  = azurerm_resource_group.rg.location
    resource_group_name       = azurerm_resource_group.rg.name
    ip_configuration {
        name                            = "${var.environment}-ipconfig"
        subnet_id                       = azurerm_subnet.subnet.id
        private_ip_address_allocation   = "Dynamic"
        public_ip_address_id            = azurerm_public_ip.public_ip[count.index].id
    }
}

# Create Public IP to allow SSH
resource "azurerm_public_ip" "public_ip" {
    count               = var.vm_count
    name                = "${var.environment}-public-ip-${count.index + 1}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    allocation_method   = "Static"
}

# Create Network Security Group
resource "azurerm_network_security_group" "nsg" {
    name                = "${var.environment}-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "nsg_association" {
    count                       = var.vm_count
    network_interface_id        = azurerm_network_interface.nic[count.index].id
    network_security_group_id   = azurerm_network_security_group.nsg.id
}

# Allow SSH traffic
resource "azurerm_network_security_rule" "ssh" {
    name                        = "SSH"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

# Generate SSH key
resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits  = 4096
    depends_on = [azurerm_resource_group.rg]
}

resource "local_file" "private_key" {
    filename = "./id_rsa"
    file_permission = "400"
    content  = tls_private_key.ssh.private_key_pem
}

resource "local_file" "public_key" {
    filename = "./id_rsa.pub"
    content  = tls_private_key.ssh.public_key_openssh
}

# Create VM with SSH key
resource "azurerm_linux_virtual_machine" "vm" {
    count                           = var.vm_count
    name                            = "${var.environment}-vm-${count.index + 1}"
    resource_group_name             = azurerm_resource_group.rg.name
    location                        = azurerm_resource_group.rg.location
    size                            = var.vm_size
    admin_username                  = var.admin_username
    admin_ssh_key {
        username                    = var.admin_username
        public_key                  = tls_private_key.ssh.public_key_openssh
    }
    network_interface_ids           = [azurerm_network_interface.nic[count.index].id]
    computer_name                   = "${var.environment}-vm"
    os_disk {
        caching                     = "ReadWrite"
        storage_account_type        = "Standard_LRS"
    }
    source_image_reference {
        publisher                   = var.os_publisher
        offer                       = var.os_offer
        sku                         = var.os_sku
        version                     = var.os_version
    }
    depends_on = [azurerm_network_interface.nic]
}
