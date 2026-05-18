variable "enforcement_mode" {
  type        = string
  default     = "block"
  description = "Default enforcement mode for all policies (block, warn, monitor)."

  validation {
    condition     = contains(["block", "warn", "monitor"], var.enforcement_mode)
    error_message = "enforcement_mode must be one of: block, warn, monitor."
  }
}

variable "status" {
  type        = string
  default     = "ACTIVE"
  description = "Default policy status (ACTIVE, INACTIVE)."

  validation {
    condition     = contains(["ACTIVE", "INACTIVE"], var.status)
    error_message = "status must be ACTIVE or INACTIVE."
  }
}

variable "scope" {
  type = object({
    user_groups      = optional(list(string), [])
    device_groups    = optional(list(string), [])
    agent_types      = optional(list(string), [])
    agent_names      = optional(list(string), [])
    mcp_servers      = optional(list(string), [])
    device_ids       = optional(list(string), [])
    excluded_users   = optional(list(string), [])
    excluded_devices = optional(list(string), [])
    excluded_agents  = optional(list(string), [])
  })
  default     = {}
  description = "Shared scope applied to all policies."
}

variable "enable_strict_filesystem" {
  type        = bool
  default     = false
  description = "Create a filesystem access policy."
}

variable "allowed_paths" {
  type        = list(string)
  default     = []
  description = "Filesystem paths to allow (read-only). Only used when enable_strict_filesystem is true."
}

variable "enable_network_control" {
  type        = bool
  default     = false
  description = "Create a network access policy."
}

variable "allowed_domains" {
  type        = list(string)
  default     = []
  description = "Domain patterns to allow. Only used when enable_network_control is true."
}

variable "enable_model_deny_list" {
  type        = bool
  default     = false
  description = "Create a model deny-list policy."
}

variable "denied_models" {
  type        = list(string)
  default     = []
  description = "Model canonical IDs to deny (e.g. deepseek/*). Only used when enable_model_deny_list is true."
}

variable "enable_credentials_protection" {
  type        = bool
  default     = false
  description = "Create a credentials protection policy."
}
