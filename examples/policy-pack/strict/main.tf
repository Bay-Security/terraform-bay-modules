terraform {
  required_providers {
    bay = {
      source  = "bay-security/bay"
      version = "~> 0.1"
    }
  }
}

provider "bay" {
  client_id     = var.bay_client_id
  client_secret = var.bay_client_secret
}

module "bay_policies" {
  source = "../../../modules/policy-pack"

  enforcement_mode = "block"
  status           = "ACTIVE"

  scope = {
    agent_names = ["claude_code", "cursor"]
    user_groups = ["Engineering"]
  }

  enable_strict_filesystem = true
  allowed_paths            = ["~/Projects/*", "/tmp/*"]

  enable_network_control = true
  allowed_domains        = ["*.github.com", "*.npmjs.org", "*.pypi.org"]

  enable_model_deny_list = true
  denied_models          = ["deepseek/*", "meta-llama/*"]

  enable_credentials_protection = true
}

variable "bay_client_id" {
  type = string
}

variable "bay_client_secret" {
  type      = string
  sensitive = true
}
