variable "oidc_provider_arn" {
  description = "EKS OIDC provider ARN"
  type        = string
}

variable "helm_releases" {
  description = "Map of Helm releases to deploy."

  type = map(object({
    repository           = string
    chart                = string
    chart_version        = string
    create_namespace     = bool
    kubernetes_namespace = string
    values               = optional(list(string), [])
    tags                 = optional(map(string))
    irsa = optional(object({
      role_name           = string
      policy_arn          = string
      serviceaccount_name = string
    }))
  }))
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}
