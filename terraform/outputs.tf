output "resource_group_name" {
  description = "Name of the deployed resource group."
  value       = azurerm_resource_group.security_lab.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.security_lab.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.security_lab.name
}
