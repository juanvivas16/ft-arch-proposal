## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.66.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../../tf-modules/alb-http | n/a |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | ../../tf-modules/seg | n/a |
| <a name="module_ec2_asg"></a> [ec2\_asg](#module\_ec2\_asg) | ../../tf-modules/ec2 | n/a |
| <a name="module_ec2_sg"></a> [ec2\_sg](#module\_ec2\_sg) | ../../tf-modules/seg | n/a |
| <a name="module_iam_ec2"></a> [iam\_ec2](#module\_iam\_ec2) | ../../tf-modules/iam | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ../../tf-modules/rds | n/a |
| <a name="module_rds_sg"></a> [rds\_sg](#module\_rds\_sg) | ../../tf-modules/seg | n/a |
| <a name="module_s3_prive_bucket"></a> [s3\_prive\_bucket](#module\_s3\_prive\_bucket) | ../../tf-modules/s3-ro | n/a |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ../../tf-modules/ssh-key | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../tf-modules/vpc-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_health_check_path"></a> [alb\_health\_check\_path](#input\_alb\_health\_check\_path) | The health check path | `string` | `"/health"` | no |
| <a name="input_alb_is_internal"></a> [alb\_is\_internal](#input\_alb\_is\_internal) | Whether the ALB is internal or not | `bool` | `false` | no |
| <a name="input_alb_load_balancing_cross_zone_enabled"></a> [alb\_load\_balancing\_cross\_zone\_enabled](#input\_alb\_load\_balancing\_cross\_zone\_enabled) | Whether to enable cross-zone load balancing | `bool` | `false` | no |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | The name of the ALB | `string` | `"tf-ft-alb"` | no |
| <a name="input_alb_tags"></a> [alb\_tags](#input\_alb\_tags) | Tags to apply to the ALB | `map(any)` | <pre>{<br>  "alb_name": "tf-ft-alb",<br>  "env": "stg"<br>}</pre> | no |
| <a name="input_alb_target_group_name"></a> [alb\_target\_group\_name](#input\_alb\_target\_group\_name) | The name of the ALB target group | `string` | `"tf-ft-target-group"` | no |
| <a name="input_ec2_cpu_alarm_down"></a> [ec2\_cpu\_alarm\_down](#input\_ec2\_cpu\_alarm\_down) | EC2 cpu alarm down | `map(any)` | <pre>{<br>  "alarm_description": "This metric monitors ec2 cpu utilization when CPU is low",<br>  "comparison_operator": "LessThanOrEqualToThreshold",<br>  "evaluation_periods": 2,<br>  "metric_name": "CPUUtilization",<br>  "period": 120,<br>  "statistic": "Average",<br>  "threshold": 10<br>}</pre> | no |
| <a name="input_ec2_cpu_alarm_up"></a> [ec2\_cpu\_alarm\_up](#input\_ec2\_cpu\_alarm\_up) | EC2 cpu alarm up | `map(any)` | <pre>{<br>  "alarm_description": "This metric monitors ec2 cpu utilization when CPU is high",<br>  "comparison_operator": "GreaterThanOrEqualToThreshold",<br>  "evaluation_periods": 2,<br>  "metric_name": "CPUUtilization",<br>  "period": 120,<br>  "statistic": "Average",<br>  "threshold": 60<br>}</pre> | no |
| <a name="input_ec2_enabled_metrics"></a> [ec2\_enabled\_metrics](#input\_ec2\_enabled\_metrics) | EC2 enabled metrics | `list(any)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| <a name="input_ec2_instance_name"></a> [ec2\_instance\_name](#input\_ec2\_instance\_name) | EC2 ASG name | `string` | `"tf-ft-ec2-asg"` | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | EC2 instance type | `string` | `"t2.medium"` | no |
| <a name="input_ec2_metrics_granularity"></a> [ec2\_metrics\_granularity](#input\_ec2\_metrics\_granularity) | EC2 metrics granularity | `string` | `"1Minute"` | no |
| <a name="input_ec2_scale_down"></a> [ec2\_scale\_down](#input\_ec2\_scale\_down) | EC2 scale down | `map(any)` | <pre>{<br>  "adjustment_type": "ChangeInCapacity",<br>  "cooldown": 90,<br>  "scaling_adjustment": -1<br>}</pre> | no |
| <a name="input_ec2_scale_up"></a> [ec2\_scale\_up](#input\_ec2\_scale\_up) | EC2 scale up | `map(any)` | <pre>{<br>  "adjustment_type": "ChangeInCapacity",<br>  "cooldown": 90,<br>  "scaling_adjustment": 1<br>}</pre> | no |
| <a name="input_ecs_desired_capacity"></a> [ecs\_desired\_capacity](#input\_ecs\_desired\_capacity) | ASG EC2 desired capacity | `number` | `2` | no |
| <a name="input_ecs_max_size"></a> [ecs\_max\_size](#input\_ecs\_max\_size) | ASG EC2 max size | `number` | `5` | no |
| <a name="input_ecs_min_size"></a> [ecs\_min\_size](#input\_ecs\_min\_size) | ASG EC2 min size | `number` | `1` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"stg"` | no |
| <a name="input_iam_assume_role_policy"></a> [iam\_assume\_role\_policy](#input\_iam\_assume\_role\_policy) | The policy that grants an entity permission to assume the role | `any` | <pre>{<br>  "Statement": [<br>    {<br>      "Action": "sts:AssumeRole",<br>      "Effect": "Allow",<br>      "Principal": {<br>        "Service": "ec2.amazonaws.com"<br>      }<br>    }<br>  ],<br>  "Version": "2012-10-17"<br>}</pre> | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | The policy that grants an entity permission to assume the role | `any` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM role | `string` | `"tf-ft-ec2-role"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name | `string` | `"ssh-local-key"` | no |
| <a name="input_local_public_ip"></a> [local\_public\_ip](#input\_local\_public\_ip) | The local public IP | `string` | n/a | yes |
| <a name="input_public_nacl_egress"></a> [public\_nacl\_egress](#input\_public\_nacl\_egress) | Network ACL egress rules | `map` | <pre>{<br>  "action": "allow",<br>  "cidr_block": "0.0.0.0/0",<br>  "from_port": "80",<br>  "protocol": "tcp",<br>  "rule_no": "100",<br>  "to_port": "80"<br>}</pre> | no |
| <a name="input_public_nacl_ingress"></a> [public\_nacl\_ingress](#input\_public\_nacl\_ingress) | Network ACL ingress rules | `map` | <pre>{<br>  "action": "allow",<br>  "cidr_block": "0.0.0.0/0",<br>  "from_port": "80",<br>  "protocol": "tcp",<br>  "rule_no": "100",<br>  "to_port": "80"<br>}</pre> | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | The allocated storage in GBs of the RDS database | `number` | `10` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | The number of days to retain backups for | `number` | `7` | no |
| <a name="input_rds_db_engine"></a> [rds\_db\_engine](#input\_rds\_db\_engine) | The engine of the RDS database | `string` | `"postgres"` | no |
| <a name="input_rds_db_engine_version"></a> [rds\_db\_engine\_version](#input\_rds\_db\_engine\_version) | The engine version of the RDS database | `string` | `"16.4"` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | The name of the RDS database | `string` | `"tfftdb"` | no |
| <a name="input_rds_db_password"></a> [rds\_db\_password](#input\_rds\_db\_password) | The password for the RDS database | `string` | `"K24Y4i3XQFd6Rd8gJn7C78XuFp7UlbTF"` | no |
| <a name="input_rds_db_username"></a> [rds\_db\_username](#input\_rds\_db\_username) | The username for the RDS database | `string` | `"tfdbuser"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance class of the RDS database | `string` | `"db.t2.medium"` | no |
| <a name="input_rds_multi_az"></a> [rds\_multi\_az](#input\_rds\_multi\_az) | Whether the RDS database is multi-AZ | `bool` | `true` | no |
| <a name="input_rds_publicly_accessible"></a> [rds\_publicly\_accessible](#input\_rds\_publicly\_accessible) | Whether the RDS database is publicly accessible | `bool` | `false` | no |
| <a name="input_rds_skip_final_snapshot"></a> [rds\_skip\_final\_snapshot](#input\_rds\_skip\_final\_snapshot) | Whether to skip the final snapshot | `bool` | `true` | no |
| <a name="input_rds_storage_encrypted"></a> [rds\_storage\_encrypted](#input\_rds\_storage\_encrypted) | Whether the RDS database is encrypted | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket | `string` | `"tf-ft-readonly-bucket"` | no |
| <a name="input_sg_alb_description"></a> [sg\_alb\_description](#input\_sg\_alb\_description) | The description of the ALB security group | `string` | `"Allow web traffic to ALB"` | no |
| <a name="input_sg_alb_egress_rules"></a> [sg\_alb\_egress\_rules](#input\_sg\_alb\_egress\_rules) | The egress rules of the ALB security group | `map(any)` | <pre>{<br>  "all_outbound": {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "from_port": 0,<br>    "ip_protocol": "tcp",<br>    "to_port": 0<br>  }<br>}</pre> | no |
| <a name="input_sg_alb_ingress_rules"></a> [sg\_alb\_ingress\_rules](#input\_sg\_alb\_ingress\_rules) | The ingress rules of the ALB security group | `map(any)` | <pre>{<br>  "http": {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "from_port": 80,<br>    "ip_protocol": "tcp",<br>    "referenced_security_group_id": "",<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "from_port": 443,<br>    "ip_protocol": "tcp",<br>    "referenced_security_group_id": "",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_sg_alb_name"></a> [sg\_alb\_name](#input\_sg\_alb\_name) | The name of the ALB security group | `string` | `"tf-ft-alb-sg"` | no |
| <a name="input_sg_ec2_description"></a> [sg\_ec2\_description](#input\_sg\_ec2\_description) | The description of the EC2 security group | `string` | `"Allow web traffic from ALB to EC2"` | no |
| <a name="input_sg_ec2_egress_rules"></a> [sg\_ec2\_egress\_rules](#input\_sg\_ec2\_egress\_rules) | The egress rules of the EC2 security group | `map(any)` | <pre>{<br>  "all_outbound": {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "from_port": 0,<br>    "ip_protocol": "-1",<br>    "to_port": 0<br>  },<br>  "rds1_outbound": {<br>    "cidr_ipv4": "10.0.3.0/24",<br>    "from_port": 5432,<br>    "ip_protocol": "tcp",<br>    "to_port": 5432<br>  },<br>  "rds2_outbound": {<br>    "cidr_ipv4": "10.0.4.0/24",<br>    "from_port": 5432,<br>    "ip_protocol": "tcp",<br>    "to_port": 5432<br>  }<br>}</pre> | no |
| <a name="input_sg_ec2_ingress_rules"></a> [sg\_ec2\_ingress\_rules](#input\_sg\_ec2\_ingress\_rules) | The ingress rules of the EC2 security group | `map(any)` | <pre>{<br>  "http_port": 80,<br>  "https_port": 443,<br>  "ip_protocol": "tcp"<br>}</pre> | no |
| <a name="input_sg_ec2_ingress_ssh_rules"></a> [sg\_ec2\_ingress\_ssh\_rules](#input\_sg\_ec2\_ingress\_ssh\_rules) | The ingress rules of the EC2 security group | `map(any)` | <pre>{<br>  "ip_protocol": "tcp",<br>  "ssh_port": 22<br>}</pre> | no |
| <a name="input_sg_ec2_name"></a> [sg\_ec2\_name](#input\_sg\_ec2\_name) | The name of the EC2 security group | `string` | `"tf-ft-ec2-sg"` | no |
| <a name="input_sg_rds_description"></a> [sg\_rds\_description](#input\_sg\_rds\_description) | The description of the RDS security group | `string` | `"Allow traffic from EC2 to RDS"` | no |
| <a name="input_sg_rds_egress_rules"></a> [sg\_rds\_egress\_rules](#input\_sg\_rds\_egress\_rules) | The egress rules of the RDS security group | `map(any)` | <pre>{<br>  "all_outbound": {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "from_port": 0,<br>    "ip_protocol": "-1",<br>    "to_port": 0<br>  }<br>}</pre> | no |
| <a name="input_sg_rds_ingress_rules"></a> [sg\_rds\_ingress\_rules](#input\_sg\_rds\_ingress\_rules) | The ingress rules of the RDS security group | `map(any)` | <pre>{<br>  "ip_protocol": "tcp",<br>  "postgres_port": 5432<br>}</pre> | no |
| <a name="input_sg_rds_name"></a> [sg\_rds\_name](#input\_sg\_rds\_name) | The name of the RDS security group | `string` | `"tf-ft-rds-sg"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | value of ssh public key path | `any` | n/a | yes |
| <a name="input_user_data_file_path"></a> [user\_data\_file\_path](#input\_user\_data\_file\_path) | User data file path | `string` | `"./files/ec2_user_data.sh"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#input\_vpc\_enable\_dns\_hostnames) | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| <a name="input_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#input\_vpc\_enable\_dns\_support) | Enable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | `"tf-ft-vpc"` | no |
| <a name="input_vpc_private_subnets"></a> [vpc\_private\_subnets](#input\_vpc\_private\_subnets) | Map of private subnets | `map(any)` | <pre>{<br>  "0": {<br>    "az": "us-east-1a",<br>    "cidr": "10.0.3.0/24"<br>  },<br>  "1": {<br>    "az": "us-east-1b",<br>    "cidr": "10.0.4.0/24"<br>  }<br>}</pre> | no |
| <a name="input_vpc_public_subnets"></a> [vpc\_public\_subnets](#input\_vpc\_public\_subnets) | Map of public subnets | `map(any)` | <pre>{<br>  "0": {<br>    "az": "us-east-1a",<br>    "cidr": "10.0.1.0/24"<br>  },<br>  "1": {<br>    "az": "us-east-1b",<br>    "cidr": "10.0.2.0/24"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | ALB DNS name |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | The IDs of the private subnets |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | The IDs of the public subnets |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | RDS endpoint |
| <a name="output_s3_domain_name"></a> [s3\_domain\_name](#output\_s3\_domain\_name) | s3 bucket domain name |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
