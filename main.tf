resource "aws_iam_role" "irsa" {
  for_each = {
    for k, v in var.helm_releases : k => v if try(v.irsa, null) != null
  }

  name = each.value.irsa.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(var.oidc_provider_arn, "arn:aws:iam::", "")}:sub" = "system:serviceaccount:${each.value.kubernetes_namespace}:${each.value.irsa.serviceaccount_name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "irsa_policy" {
  for_each = {
    for k, v in var.helm_releases : k => v if try(v.irsa, null) != null
  }

  role       = aws_iam_role.irsa[each.key].name
  policy_arn = each.value.irsa.policy_arn
}

resource "helm_release" "this" {
  for_each = var.helm_releases

  name             = each.key
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.chart_version
  create_namespace = each.value.create_namespace
  namespace        = each.value.kubernetes_namespace
  atomic           = true
  cleanup_on_fail  = true

  values = concat(
    each.value.values,
    lookup(each.value, "tags", null) != null ? [
      yamlencode({ tags = each.value.tags })
    ] : [],
    try(each.value.irsa, null) != null ? [
      yamlencode({
        serviceAccount = {
          name   = each.value.irsa.serviceaccount_name
          create = true
          annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.irsa[each.key].arn
          }
        }
      })
    ] : []
  )
}
