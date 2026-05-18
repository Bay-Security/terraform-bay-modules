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
    agent_names = ["claude_code"]
  }

  enable_strict_filesystem = true
  allowed_paths            = ["~/Projects/*"]

  enable_credentials_protection = true
}

variable "bay_client_id" {
  type = string
}

variable "bay_client_secret" {
  type      = string
  sensitive = true
}
