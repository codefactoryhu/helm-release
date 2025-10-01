variable "name" {
  type        = string
  description = "The name of the Helm release."
}

variable "repository" {
  type        = string
  description = "Repository URL where to locate the requested chart."
}

variable "chart" {
  type        = string
  description = "Chart name to be installed. Can be local path, URL or repository/chart format."
}

variable "chart_version" {
  type        = string
  description = "Specify the exact chart version to install."
  default     = null
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace via Helm if it does not exist."
  default     = true
}

variable "kubernetes_namespace" {
  type        = string
  description = "The namespace to install the release into."
  default     = "default"
}
