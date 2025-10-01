resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  version          = var.chart_version
  create_namespace = var.create_namespace
  namespace        = var.kubernetes_namespace
}
