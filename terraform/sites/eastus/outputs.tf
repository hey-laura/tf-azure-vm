# Outputs for the root module

output "vm_ids" {
    description = "The IDs of the created virtual machines"
    value       = module.azure-vm.vm_ids
}

output "vm_names" {
    description = "The names of the created virtual machines"
    value       = module.azure-vm.vm_names
}

output "public_ips" {
    description = "The public IP addresses of the virtual machines"
    value       = module.azure-vm.public_ips
}

output "current_subscription_display_name" {
    description = "The display name of the current subscription"
    value       = module.azure-vm.current_subscription_id
}