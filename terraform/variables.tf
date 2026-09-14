variable "subscription_id" {
  description = "Azure subscription ID used for the lab deployment."
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region for lab resources."
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group for the cloud security lab."
  type        = string
  default     = "rg-cloud-security-lab"
}

variable "log_analytics_workspace_name" {
  description = "Log Analytics workspace used by Microsoft Sentinel."
  type        = string
  default     = "law-cloud-security-lab"
}

variable "retention_in_days" {
  description = "Log Analytics data retention period."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30
    error_message = "Retention must be at least 30 days."
  }
}

variable "tags" {
  description = "Tags applied to lab resources."
  type        = map(string)
  default = {
    environment = "lab"
    managed-by  = "terraform"
    workload    = "cloud-security"
  }
}
