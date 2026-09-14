resource "azurerm_resource_group" "security_lab" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "security_lab" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.security_lab.location
  resource_group_name = azurerm_resource_group.security_lab.name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "security_lab" {
  workspace_id = azurerm_log_analytics_workspace.security_lab.id
}
