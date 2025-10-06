# Helm release

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.irsa_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_helm_releases"></a> [helm\_releases](#input\_helm\_releases) | Map of Helm releases to deploy. | <pre>map(object({<br/>    repository           = string<br/>    chart                = string<br/>    chart_version        = string<br/>    create_namespace     = bool<br/>    kubernetes_namespace = string<br/>    values               = optional(list(string), [])<br/>    tags                 = optional(map(string))<br/>    irsa = optional(object({<br/>      role_name           = string<br/>      policy_arn          = string<br/>      serviceaccount_name = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | EKS OIDC provider ARN | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_release_charts"></a> [release\_charts](#output\_release\_charts) | The chart used for each deployed Helm release |
| <a name="output_release_names"></a> [release\_names](#output\_release\_names) | The names of all deployed Helm releases |
| <a name="output_release_namespaces"></a> [release\_namespaces](#output\_release\_namespaces) | The namespace of each deployed Helm release. |
| <a name="output_release_statuses"></a> [release\_statuses](#output\_release\_statuses) | The status of each deployed Helm release. |
| <a name="output_release_values"></a> [release\_values](#output\_release\_values) | The computed values for each Helm release. |
