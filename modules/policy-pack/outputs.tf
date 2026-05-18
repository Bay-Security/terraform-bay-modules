output "filesystem_policy_id" {
  value       = one(bay_policy.filesystem[*].id)
  description = "ID of the filesystem access control policy."
}

output "network_policy_id" {
  value       = one(bay_policy.network[*].id)
  description = "ID of the network access control policy."
}

output "model_deny_policy_id" {
  value       = one(bay_policy.model_deny[*].id)
  description = "ID of the model deny list policy."
}

output "credentials_policy_id" {
  value       = one(bay_policy.credentials[*].id)
  description = "ID of the credentials protection policy."
}
