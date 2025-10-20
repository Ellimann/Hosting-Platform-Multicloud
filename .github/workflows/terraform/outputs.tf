output "aws_instance_ip" {
  description = "AWS Instance Public IP"
  value       = aws_instance.web_aws.public_ip
}

output "azure_vm_name" {
  description = "Azure VM Name"
  value       = azurerm_linux_virtual_machine.vm_azure.name
}

output "gcp_vm_ip" {
  description = "GCP VM Public IP"
  value       = google_compute_instance.vm_gcp.network_interface[0].access_config[0].nat_ip
}
