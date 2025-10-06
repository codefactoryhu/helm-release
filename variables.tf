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
    force_update         = optional(bool, true)
    values               = optional(list(string), [])
    tags                 = optional(map(string))
    irsa = optional(object({
      role_name                           = string
      policy_arn                          = string
      serviceaccount_name                 = string
      serviceaccount_set_name_path        = optional(string, "serviceAccount.name")
      serviceaccount_set_create_path      = optional(string, "serviceAccount.create")
      serviceaccount_set_annotations_path = optional(string, "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn")
    }))
  }))
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}
