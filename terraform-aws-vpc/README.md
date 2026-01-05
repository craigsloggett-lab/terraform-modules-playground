# AWS VPC Terraform Module

A Terraform module to deploy a VPC to an AWS account using sane defaults and automatic subnetting.

## Input Defaults

| Variable                      | Default                                                                                                          |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| vpc_cidr                      | `"10.0.0.0/16"`                                                                                                  |
| number_of_azs                 | `3`                                                                                                              |
| public_subnet_cidrs           | `null`                                                                                                           |
| private_app_subnet_cidrs      | `null`                                                                                                           |
| private_data_subnet_cidrs     | `null`                                                                                                           |
| create_database_subnet_groups | `false`                                                                                                          |
| enable_dns_hostnames          | `true`                                                                                                           |
| enable_dns_support            | `true`                                                                                                           |
| enable_nat_gateway            | `true`                                                                                                           |
| single_nat_gateway            | `false`                                                                                                          |
| one_nat_gateway_per_az        | `true`                                                                                                           |
| manage_default_network_acl    | `true`                                                                                                           |
| default_network_acl_ingress   | `[ { rule_no = 100, action = "allow", from_port = 0, to_port = 0, protocol = "-1", cidr_block = "0.0.0.0/0" } ]` |
| default_network_acl_egress    | `[ { rule_no = 100, action = "allow", from_port = 0, to_port = 0, protocol = "-1", cidr_block = "0.0.0.0/0" } ]` |
| enable_flow_log               | `true`                                                                                                           |
| flow_logs_retention_days      | `30`                                                                                                             |
| flow_logs_traffic_type        | `"ALL"`                                                                                                          |
| waypoint_application          | `null`                                                                                                           |


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 6.5.1 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb_private_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb_private_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3_private_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3_private_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_database_subnet_groups"></a> [create\_database\_subnet\_groups](#input\_create\_database\_subnet\_groups) | Whether to create database subnet groups. Recommended to set this to 'false' and create database subnet groups when creating a database. | `bool` | n/a | yes |
| <a name="input_default_network_acl_egress"></a> [default\_network\_acl\_egress](#input\_default\_network\_acl\_egress) | List of maps of egress rules for default network ACL. | <pre>list(object({<br/>    rule_no    = number<br/>    action     = string<br/>    from_port  = number<br/>    to_port    = number<br/>    protocol   = string<br/>    cidr_block = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "action": "allow",<br/>    "cidr_block": "0.0.0.0/0",<br/>    "from_port": 0,<br/>    "protocol": "-1",<br/>    "rule_no": 100,<br/>    "to_port": 0<br/>  }<br/>]</pre> | no |
| <a name="input_default_network_acl_ingress"></a> [default\_network\_acl\_ingress](#input\_default\_network\_acl\_ingress) | List of maps of ingress rules for default network ACL. | <pre>list(object({<br/>    rule_no    = number<br/>    action     = string<br/>    from_port  = number<br/>    to_port    = number<br/>    protocol   = string<br/>    cidr_block = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "action": "allow",<br/>    "cidr_block": "0.0.0.0/0",<br/>    "from_port": 0,<br/>    "protocol": "-1",<br/>    "rule_no": 100,<br/>    "to_port": 0<br/>  }<br/>]</pre> | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostnames in the VPC. | `bool` | n/a | yes |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support in the VPC. | `bool` | n/a | yes |
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Enable VPC Flow Logs for network traffic analysis and security. | `bool` | n/a | yes |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateway for private subnet internet access. Required for private subnets to access the internet. | `bool` | n/a | yes |
| <a name="input_flow_logs_retention_days"></a> [flow\_logs\_retention\_days](#input\_flow\_logs\_retention\_days) | Number of days to retain VPC Flow Logs in CloudWatch. | `number` | n/a | yes |
| <a name="input_flow_logs_traffic_type"></a> [flow\_logs\_traffic\_type](#input\_flow\_logs\_traffic\_type) | The type of traffic to capture in flow logs. Valid values: ACCEPT, REJECT, ALL. | `string` | n/a | yes |
| <a name="input_manage_default_network_acl"></a> [manage\_default\_network\_acl](#input\_manage\_default\_network\_acl) | Manage the default network ACL. Set to false to leave it unmanaged. | `bool` | n/a | yes |
| <a name="input_number_of_azs"></a> [number\_of\_azs](#input\_number\_of\_azs) | Number of Availability Zones to use. Must be at least 2 for high availability. | `number` | n/a | yes |
| <a name="input_one_nat_gateway_per_az"></a> [one\_nat\_gateway\_per\_az](#input\_one\_nat\_gateway\_per\_az) | Create one NAT Gateway per Availability Zone for high availability. | `bool` | n/a | yes |
| <a name="input_private_app_subnet_cidrs"></a> [private\_app\_subnet\_cidrs](#input\_private\_app\_subnet\_cidrs) | List of CIDR blocks for private application subnets. If not provided, will be calculated automatically from VPC CIDR. | `list(string)` | `null` | no |
| <a name="input_private_data_subnet_cidrs"></a> [private\_data\_subnet\_cidrs](#input\_private\_data\_subnet\_cidrs) | List of CIDR blocks for private data subnets (databases, caches). If not provided, will be calculated automatically from VPC CIDR. | `list(string)` | `null` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of CIDR blocks for public subnets. If not provided, will be calculated automatically from VPC CIDR. | `list(string)` | `null` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Use a single NAT Gateway for all private subnets (cost optimization) vs one per AZ (high availability). | `bool` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC. Must be /16 for automatic subnet calculation. Choose a CIDR that does not overlap with other VPCs you may peer with or on-premises networks. | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC. This will be used in the Name tag and subnet naming. | `string` | n/a | yes |
| <a name="input_waypoint_application"></a> [waypoint\_application](#input\_waypoint\_application) | The Waypoint Application name injected during a Waypoint application deployment. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | AWS account ID where the VPC is created |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of availability zones used |
| <a name="output_database_route_table_ids"></a> [database\_route\_table\_ids](#output\_database\_route\_table\_ids) | List of IDs of database route tables |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | Name of database subnet group (for RDS) |
| <a name="output_dynamodb_vpc_endpoint_id"></a> [dynamodb\_vpc\_endpoint\_id](#output\_dynamodb\_vpc\_endpoint\_id) | ID of the DynamoDB VPC endpoint |
| <a name="output_flow_log_cloudwatch_iam_role_arn"></a> [flow\_log\_cloudwatch\_iam\_role\_arn](#output\_flow\_log\_cloudwatch\_iam\_role\_arn) | The ARN of the IAM role used when pushing logs to Cloudwatch log group. |
| <a name="output_flow_log_id"></a> [flow\_log\_id](#output\_flow\_log\_id) | ID of the VPC Flow Log |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the Internet Gateway |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | List of NAT Gateway IDs |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for NAT Gateways |
| <a name="output_private_app_subnet_cidrs"></a> [private\_app\_subnet\_cidrs](#output\_private\_app\_subnet\_cidrs) | List of CIDR blocks of private application subnets |
| <a name="output_private_app_subnet_ids"></a> [private\_app\_subnet\_ids](#output\_private\_app\_subnet\_ids) | List of IDs of private application subnets |
| <a name="output_private_data_subnet_cidrs"></a> [private\_data\_subnet\_cidrs](#output\_private\_data\_subnet\_cidrs) | List of CIDR blocks of private data subnets |
| <a name="output_private_data_subnet_ids"></a> [private\_data\_subnet\_ids](#output\_private\_data\_subnet\_ids) | List of IDs of private data subnets |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | List of CIDR blocks of public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | List of IDs of public subnets |
| <a name="output_region"></a> [region](#output\_region) | AWS region where the VPC is created |
| <a name="output_s3_vpc_endpoint_id"></a> [s3\_vpc\_endpoint\_id](#output\_s3\_vpc\_endpoint\_id) | ID of the S3 VPC endpoint |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The name of the VPC |
| <a name="output_waypoint_application"></a> [waypoint\_application](#output\_waypoint\_application) | The Waypoint Application name injected during a Waypoint application deployment. |
<!-- END_TF_DOCS -->
