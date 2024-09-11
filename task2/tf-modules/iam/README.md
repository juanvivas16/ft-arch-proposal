## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The role policy variables | <pre>object({<br>    Version = string<br>    Statement = list(object({<br>      Action = string<br>      Effect = string<br>      Principal = object({<br>        Service = string<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"stg"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | Policy definition por iam role | <pre>object({<br>    Version = string<br>    Statement = list(object({<br>      Effect   = string<br>      Action   = list(string)<br>      Resource = list(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the IAM role | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | The name of the instance profile assigned to EC2 |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the IAM role assigned to EC2 |
