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
  force_update     = each.value.force_update
  atomic           = each.value.atomic
  cleanup_on_fail  = each.value.cleanup_on_fail
  values           = each.value.values

  set = try(each.value.irsa, null) != null ? [
    {
      name  = each.value.irsa.serviceaccount_set_name_path
      value = each.value.irsa.serviceaccount_name
    },
    {
      name  = each.value.irsa.serviceaccount_set_create_path
      value = true
    },
    {
      name  = each.value.irsa.serviceaccount_set_annotations_path
      value = aws_iam_role.irsa[each.key].arn
    }
  ] : []

}
