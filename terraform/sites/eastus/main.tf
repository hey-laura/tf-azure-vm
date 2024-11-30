# Create vm from module azure-vm
module "azure-vm" {
    source = "../../modules/azure-vm"
    location = "eastus"
    environment = "dev"
    tags = {
        "type" = "vm"
    }
}
