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

  scope = {
    agent_types = ["coding_agent"]
  }

  enable_model_deny_list = true
  denied_models          = ["deepseek/*"]
}

variable "bay_client_id" {
  type = string
}

variable "bay_client_secret" {
  type      = string
  sensitive = true
}
