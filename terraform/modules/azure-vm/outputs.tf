# Define the outputs for the Azure VM module
output "current_subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}

output "vm_ids" {
    value = azurerm_linux_virtual_machine.vm[*].id
}

output "vm_names" {
    value = azurerm_linux_virtual_machine.vm[*].name
}

output "public_ips" {
    value = azurerm_linux_virtual_machine.vm[*].public_ip_address
}

