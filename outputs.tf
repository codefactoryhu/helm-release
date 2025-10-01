output "release_name" {
  value       = helm_release.this.name
  description = "The name of the deployed Helm release."
}

output "namespace" {
  value       = helm_release.this.namespace
  description = "The namespace where the Helm release was installed."
}

output "chart" {
  value       = helm_release.this.chart
  description = "The chart deployed by this Helm release."
}
