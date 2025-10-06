output "release_names" {
  description = "The names of all deployed Helm releases"
  value       = [for r in helm_release.this : r.name]
}

output "release_charts" {
  description = "The chart used for each deployed Helm release"
  value       = { for k, r in helm_release.this : k => r.chart }
}

output "release_namespaces" {
  description = "The namespace of each deployed Helm release."
  value       = { for k, r in helm_release.this : k => r.namespace }
}

output "release_values" {
  description = "The computed values for each Helm release."
  value       = { for k, r in helm_release.this : k => r.values }
}

output "release_statuses" {
  description = "The status of each deployed Helm release."
  value       = { for k, r in helm_release.this : k => r.status }
}
