# terraform-aws-elasticache

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.27.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_aws_elasticache"></a> [terraform\_aws\_elasticache](#module\_terraform\_aws\_elasticache) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.elasticache_slow_log](https://registry.terraform.io/providers/hashicorp/aws/6.27.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/6.27.0/docs/data-sources/subnets) | data source |
| [aws_vpc.elasticache](https://registry.terraform.io/providers/hashicorp/aws/6.27.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC (as defined in the Name tag) where the ElastiCache cluster will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auth_token"></a> [auth\_token](#output\_auth\_token) | The auth token for the cache cluster |
| <a name="output_cluster_enabled"></a> [cluster\_enabled](#output\_cluster\_enabled) | Whether cluster mode is enabled |
| <a name="output_engine"></a> [engine](#output\_engine) | The cache engine |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | The running version of the cache engine |
| <a name="output_member_clusters"></a> [member\_clusters](#output\_member\_clusters) | List of member cluster IDs |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The name of the parameter group |
| <a name="output_port"></a> [port](#output\_port) | The port number on which the cache accepts connections |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output\_primary\_endpoint\_address) | The address of the primary endpoint |
| <a name="output_reader_endpoint_address"></a> [reader\_endpoint\_address](#output\_reader\_endpoint\_address) | The address of the reader endpoint |
| <a name="output_replication_group_arn"></a> [replication\_group\_arn](#output\_replication\_group\_arn) | The ARN of the ElastiCache replication group |
| <a name="output_replication_group_id"></a> [replication\_group\_id](#output\_replication\_group\_id) | The ID of the ElastiCache replication group |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The name of the cache subnet group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where the ElastiCache cluster is deployed |
<!-- END_TF_DOCS -->