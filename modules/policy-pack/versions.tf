terraform {
  required_version = ">= 1.0"

  required_providers {
    bay = {
      source  = "bay-security/bay"
      version = "~> 0.1"
    }
  }
}
