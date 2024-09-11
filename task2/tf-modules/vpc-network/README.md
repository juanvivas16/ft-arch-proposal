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
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.public_nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_subnet_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostnames | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"stg"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of private subnets with CIDR and availability zone | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | <pre>{<br>  "0": {<br>    "az": "us-east-1a",<br>    "cidr": "10.0.3.0/24"<br>  },<br>  "1": {<br>    "az": "us-east-1b",<br>    "cidr": "10.0.4.0/24"<br>  }<br>}</pre> | no |
| <a name="input_public_nacl_egress"></a> [public\_nacl\_egress](#input\_public\_nacl\_egress) | Network ACL egress rules | `map(string)` | n/a | yes |
| <a name="input_public_nacl_ingress"></a> [public\_nacl\_ingress](#input\_public\_nacl\_ingress) | Network ACL ingress rules | `map(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Map of public subnets with CIDR and availability zone | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | <pre>{<br>  "0": {<br>    "az": "us-east-1a",<br>    "cidr": "10.0.1.0/24"<br>  },<br>  "1": {<br>    "az": "us-east-1b",<br>    "cidr": "10.0.2.0/24"<br>  }<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT Gateway |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | The IDs of the private subnets |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | The IDs of the public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
