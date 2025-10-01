resource "helm_release" "this" {
  for_each = var.helm_releases

  name             = each.key
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.chart_version
  create_namespace = each.value.create_namespace
  namespace        = each.value.kubernetes_namespace

  atomic          = true
  cleanup_on_fail = true

  # it only works if the locals.tags input is a map
  values = lookup(each.value, "tags", null) != null ? [
    yamlencode({ tags = each.value.tags })
  ] : []
}
