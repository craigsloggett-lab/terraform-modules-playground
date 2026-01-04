<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.engine_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.slow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.elasticache_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.elasticache_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_password.auth_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_kms_key.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the cache. Should typically be your VPC CIDR or application subnet CIDRs. | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group IDs allowed to access the cache (e.g., application server security groups). | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply changes immediately instead of during the next maintenance window. | `bool` | `false` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Enable encryption at rest. Cannot be disabled for compliance. | `bool` | `true` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | The password used to access the cache. Required if auth\_token\_enabled is true. If not provided, one will be generated. Must be 16-128 characters. | `string` | `null` | no |
| <a name="input_auth_token_enabled"></a> [auth\_token\_enabled](#input\_auth\_token\_enabled) | Enable Redis AUTH token for authentication. Recommended for production. | `bool` | `true` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Enable automatic minor version upgrades during the maintenance window. | `bool` | `true` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Enable automatic failover for the replication group. Required when num\_cache\_clusters > 1 or cluster mode is enabled. | `bool` | `true` | no |
| <a name="input_cloudwatch_logs_retention_days"></a> [cloudwatch\_logs\_retention\_days](#input\_cloudwatch\_logs\_retention\_days) | The number of days to retain CloudWatch logs. Only used if log delivery is configured. | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the replication group. | `string` | `null` | no |
| <a name="input_elasticache_kms_key_id"></a> [elasticache\_kms\_key\_id](#input\_elasticache\_kms\_key\_id) | The ARN of the KMS key for encryption at rest. If not specified, uses the default aws/elasticache key. | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The cache engine to use. Valid values are 'redis' or 'valkey'. | `string` | `"valkey"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the cache engine. For Redis: 7.x. For Valkey: 7.2 or higher. | `string` | `"7.2"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier for the ElastiCache replication group. Must be unique within your AWS account in the current region. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The weekly time range for maintenance (e.g., 'sun:05:00-sun:06:00'). Must not overlap with snapshot\_window. | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Enable Multi-AZ for automatic failover. Requires automatic\_failover\_enabled to be true. | `bool` | `true` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The instance class for the cache nodes. | `string` | `"cache.t3.medium"` | no |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | Number of cache clusters (primary and replicas). Must be at least 2 for automatic failover. Ignored if cluster mode is enabled. | `number` | `2` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | Number of node groups (shards) for cluster mode. Set to 1 to disable cluster mode. | `number` | `1` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the parameter group. If not provided, defaults to '{identifier}-pg'. | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | List of parameters to apply to the cache cluster. | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | Number of replica nodes per node group (shard). Only used when cluster mode is enabled. | `number` | `0` | no |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | The replication group identifier. If not provided, uses the identifier variable. | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group. If not provided, defaults to '{identifier}-sg'. | `string` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | Number of days to retain automatic snapshots. Set to 0 to disable automated backups. | `number` | `7` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range during which automated backups are created (e.g., '03:00-05:00'). Must not overlap with maintenance\_window. | `string` | `"03:00-05:00"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of the cache subnet group. If not provided, defaults to '{identifier}-subnet-group'. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the cache subnet group. Should be private subnets across multiple AZs for high availability. | `list(string)` | n/a | yes |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Enable encryption in transit (TLS). Cannot be disabled for compliance. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the ElastiCache cluster will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auth_token"></a> [auth\_token](#output\_auth\_token) | The auth token for the cache cluster |
| <a name="output_cluster_enabled"></a> [cluster\_enabled](#output\_cluster\_enabled) | Whether cluster mode is enabled |
| <a name="output_configuration_endpoint_address"></a> [configuration\_endpoint\_address](#output\_configuration\_endpoint\_address) | The address of the configuration endpoint (for cluster mode enabled) |
| <a name="output_engine"></a> [engine](#output\_engine) | The cache engine (redis or valkey) |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | The running version of the cache engine |
| <a name="output_member_clusters"></a> [member\_clusters](#output\_member\_clusters) | List of member cluster IDs |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The name of the parameter group |
| <a name="output_port"></a> [port](#output\_port) | The port number on which the cache accepts connections |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output\_primary\_endpoint\_address) | The address of the primary endpoint (for Redis/Valkey in non-cluster mode) |
| <a name="output_reader_endpoint_address"></a> [reader\_endpoint\_address](#output\_reader\_endpoint\_address) | The address of the reader endpoint (for Redis/Valkey in non-cluster mode) |
| <a name="output_replication_group_arn"></a> [replication\_group\_arn](#output\_replication\_group\_arn) | The ARN of the ElastiCache replication group |
| <a name="output_replication_group_id"></a> [replication\_group\_id](#output\_replication\_group\_id) | The ID of the ElastiCache replication group |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The name of the cache subnet group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where the ElastiCache cluster is deployed |
<!-- END_TF_DOCS -->