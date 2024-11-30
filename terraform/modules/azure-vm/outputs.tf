# Define the outputs for the Azure VM module
output "current_subscription_id" {
    value = data.azurerm_subscription.current.id
}

output "vm_ids" {
    value = [for vm in azurerm_linux_virtual_machine.vm : vm.id]
}

output "vm_names" {
    value = [for vm in azurerm_linux_virtual_machine.vm : vm.name]  
}

output "public_ips" {
    value = [for ip in azurerm_public_ip.public_ip : ip.ip_address]
}

