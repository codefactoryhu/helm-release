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
  }))
}

variable "irsa" {
  description = "Optional IRSA configuration for Helm releases."

  type = map(object({
    role_name       = string
    policy_arn      = string
    namespace       = string
    service_account = string
  }))
}
