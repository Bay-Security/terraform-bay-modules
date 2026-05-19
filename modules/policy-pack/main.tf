resource "bay_policy" "filesystem" {
  count = var.enable_strict_filesystem ? 1 : 0

  name             = "Filesystem Access Control"
  description      = "Restrict agent filesystem access to approved paths"
  enforcement_mode = var.enforcement_mode
  policy_type      = "agentic"
  status           = var.status

  scope {
    user_groups      = var.scope.user_groups
    device_groups    = var.scope.device_groups
    agent_types      = var.scope.agent_types
    agent_names      = var.scope.agent_names
    mcp_servers      = var.scope.mcp_servers
    device_ids       = var.scope.device_ids
    excluded_users   = var.scope.excluded_users
    excluded_devices = var.scope.excluded_devices
    excluded_agents  = var.scope.excluded_agents
  }

  dynamic "rule" {
    for_each = var.allowed_paths
    content {
      category     = "filesystem"
      operator     = "ALLOW_RO"
      pattern      = rule.value
      priority     = rule.key + 1
      user_allowed = true
    }
  }

  rule {
    category = "filesystem"
    operator = "DENY"
    pattern  = "*"
    priority = 1000
  }
}

resource "bay_policy" "network" {
  count = var.enable_network_control ? 1 : 0

  name             = "Network Access Control"
  description      = "Restrict agent network access to approved domains"
  enforcement_mode = var.enforcement_mode
  policy_type      = "agentic"
  status           = var.status

  scope {
    user_groups      = var.scope.user_groups
    device_groups    = var.scope.device_groups
    agent_types      = var.scope.agent_types
    agent_names      = var.scope.agent_names
    mcp_servers      = var.scope.mcp_servers
    device_ids       = var.scope.device_ids
    excluded_users   = var.scope.excluded_users
    excluded_devices = var.scope.excluded_devices
    excluded_agents  = var.scope.excluded_agents
  }

  dynamic "rule" {
    for_each = var.allowed_domains
    content {
      category     = "network"
      operator     = "ALLOW"
      pattern      = rule.value
      priority     = rule.key + 1
      user_allowed = true
    }
  }

  rule {
    category = "network"
    operator = "DENY"
    pattern  = "*"
    priority = 1000
  }
}

resource "bay_policy" "model_deny" {
  count = var.enable_model_deny_list ? 1 : 0

  name             = "Model Deny List"
  description      = "Block unapproved AI models"
  enforcement_mode = var.enforcement_mode
  policy_type      = "model_control"
  status           = var.status

  scope {
    user_groups      = var.scope.user_groups
    device_groups    = var.scope.device_groups
    agent_types      = var.scope.agent_types
    agent_names      = var.scope.agent_names
    mcp_servers      = var.scope.mcp_servers
    device_ids       = var.scope.device_ids
    excluded_users   = var.scope.excluded_users
    excluded_devices = var.scope.excluded_devices
    excluded_agents  = var.scope.excluded_agents
  }

  dynamic "model_rule" {
    for_each = var.denied_models
    content {
      canonical_id = model_rule.value
      action       = "deny"
    }
  }
}

resource "bay_policy" "credentials" {
  count = var.enable_credentials_protection ? 1 : 0

  name             = "Credentials Protection"
  description      = "Prevent agents from accessing credentials and secrets"
  enforcement_mode = var.enforcement_mode
  policy_type      = "agentic"
  status           = var.status

  scope {
    user_groups      = var.scope.user_groups
    device_groups    = var.scope.device_groups
    agent_types      = var.scope.agent_types
    agent_names      = var.scope.agent_names
    mcp_servers      = var.scope.mcp_servers
    device_ids       = var.scope.device_ids
    excluded_users   = var.scope.excluded_users
    excluded_devices = var.scope.excluded_devices
    excluded_agents  = var.scope.excluded_agents
  }

  rule {
    category = "credentials"
    operator = "DENY"
    pattern  = "*"
    priority = 1000
  }
}
