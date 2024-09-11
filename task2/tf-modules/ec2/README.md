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
| [aws_autoscaling_group.ec2_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.cpu_alarm_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_alarm_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_launch_configuration.ec2_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_alarm_down"></a> [cpu\_alarm\_down](#input\_cpu\_alarm\_down) | Cloudwatch cpu alarm down values | `map(any)` | <pre>{<br>  "alarm_description": "This metric monitors ec2 cpu utilization when CPU is low",<br>  "comparison_operator": "LessThanOrEqualToThreshold",<br>  "evaluation_periods": 2,<br>  "metric_name": "CPUUtilization",<br>  "period": 120,<br>  "statistic": "Average",<br>  "threshold": 10<br>}</pre> | no |
| <a name="input_cpu_alarm_up"></a> [cpu\_alarm\_up](#input\_cpu\_alarm\_up) | Cloudwatch cpu alarm up values | `map(any)` | <pre>{<br>  "alarm_description": "This metric monitors ec2 cpu utilization when CPU is high",<br>  "comparison_operator": "GreaterThanOrEqualToThreshold",<br>  "evaluation_periods": 2,<br>  "metric_name": "CPUUtilization",<br>  "period": 120,<br>  "statistic": "Average",<br>  "threshold": 60<br>}</pre> | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of instances in the Auto Scaling Group | `number` | `1` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | List of enabled metrics | `list(string)` | n/a | yes |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | IAM instance profile for the EC2 instance (optional) | `string` | `""` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Tag name for the EC2 instances | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to be used for EC2 instances | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of instances in the Auto Scaling Group | `number` | `5` | no |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | Granularity of the metrics (1Minute, 5Minutes, 1Hour) | `string` | `"1Minute"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of instances in the Auto Scaling Group | `number` | `1` | no |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | List of public subnet IDs where the EC2 instances will be launched | `list(string)` | n/a | yes |
| <a name="input_scale_down"></a> [scale\_down](#input\_scale\_down) | Auto Scaling Policy variables | <pre>object({<br>    scaling_adjustment = number<br>    adjustment_type    = string<br>    cooldown           = number<br>  })</pre> | n/a | yes |
| <a name="input_scale_up"></a> [scale\_up](#input\_scale\_up) | Auto Scaling Policy variables | <pre>object({<br>    scaling_adjustment = number<br>    adjustment_type    = string<br>    cooldown           = number<br>  })</pre> | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security Group ID for the EC2 instances | `string` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the target group for the ALB | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run when launching the EC2 instances | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the Auto Scaling Group |
| <a name="output_instance_type"></a> [instance\_type](#output\_instance\_type) | The instance type of the EC2 instances |
| <a name="output_launch_configuration_id"></a> [launch\_configuration\_id](#output\_launch\_configuration\_id) | The ID of the EC2 Launch Configuration |
