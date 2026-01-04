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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.upgrade](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.rds_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_kms_key.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in GiB. | `number` | `64` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the database. Should typically be your VPC CIDR or application subnet CIDRs. | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group IDs allowed to access the database (e.g., application server security groups). | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately or during the next maintenance window. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically during the maintenance window. | `bool` | `true` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups. Must be between 1 and 35. Set to 0 to disable automated backups (not recommended). | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range during which automated backups are created (e.g., '03:00-04:00'). Must not overlap with maintenance\_window. | `string` | `"03:00-04:00"` | no |
| <a name="input_cloudwatch_logs_retention_days"></a> [cloudwatch\_logs\_retention\_days](#input\_cloudwatch\_logs\_retention\_days) | The number of days to retain CloudWatch logs. | `number` | `30` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all instance tags to snapshots. | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database to create when the DB instance is created. If not provided, no database is created. | `string` | `null` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If true, the database cannot be deleted. Recommended for production databases. | `bool` | `true` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The name of the RDS instance. Must be unique within your AWS account in the current region. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance. | `string` | `"db.t3.medium"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS. Required for io1 and io2 storage types. | `number` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance (e.g., 'Mon:04:00-Mon:05:00'). Must not overlap with backup\_window. | `string` | `"Mon:04:00-Mon:05:00"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The upper limit in GiB which RDS can automatically scale the storage. Set to 0 to disable storage autoscaling. | `number` | `0` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to create. If not provided, defaults to '{identifier}-pg'. | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameters to apply. Use this to customize PostgreSQL configuration. | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "name": "log_statement",<br/>    "value": "all"<br/>  },<br/>  {<br/>    "name": "log_min_duration_statement",<br/>    "value": "1000"<br/>  }<br/>]</pre> | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled. | `bool` | `true` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | The number of days to retain Performance Insights data. Valid values are 7, 31, 62, 93, 124, 155, 186, 217, 248, 279, 310, 341, 372, 403, 434, 465, 496, 527, 558, 589, 620, 651, 682, 713, 731. | `number` | `7` | no |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | The version of PostgreSQL to use. Use format 'major.minor' (e.g., '16.4'). | `string` | `"18.1"` | no |
| <a name="input_rds_kms_key_id"></a> [rds\_kms\_key\_id](#input\_rds\_kms\_key\_id) | The ARN for the KMS encryption key for RDS storage and Performance Insights. If not specified, uses the default aws/rds key. | `string` | `null` | no |
| <a name="input_secrets_manager_kms_key_id"></a> [secrets\_manager\_kms\_key\_id](#input\_secrets\_manager\_kms\_key\_id) | The ARN for the KMS encryption key for Secrets Manager. If not specified, uses the default aws/secretsmanager key. | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group. If not provided, defaults to '{identifier}-sg'. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before deletion. Set to false for production. | `bool` | `false` | no |
| <a name="input_storage_throughput"></a> [storage\_throughput](#input\_storage\_throughput) | The storage throughput value for gp3 storage type (MiB/s). | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The storage type. Can be 'gp2', 'gp3', 'io1', or 'io2'. | `string` | `"gp3"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of the DB subnet group. If not provided, defaults to '{identifier}-subnet-group'. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the DB subnet group. Should be private subnets across multiple AZs for high availability. | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for the DB user. Cannot be 'postgres' as it's reserved. | `string` | `"dbadmin"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the VPC where the RDS instance will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The hostname of the RDS instance |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zones of the instance (for single-AZ deployments) |
| <a name="output_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#output\_cloudwatch\_log\_groups) | Map of CloudWatch log group names |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | The name of the database |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The connection endpoint in address:port format |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | The running version of the database engine |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The RDS instance ID |
| <a name="output_instance_resource_id"></a> [instance\_resource\_id](#output\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | The ARN of the db parameter group |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The db parameter group name |
| <a name="output_performance_insights_enabled"></a> [performance\_insights\_enabled](#output\_performance\_insights\_enabled) | Whether Performance Insights is enabled |
| <a name="output_port"></a> [port](#output\_port) | The port the database is listening on |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_subnet_group_arn"></a> [subnet\_group\_arn](#output\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The db subnet group name |
| <a name="output_user_password_secret_arn"></a> [user\_password\_secret\_arn](#output\_user\_password\_secret\_arn) | The ARN of the secret containing the user password |
| <a name="output_user_password_secret_kms_key_id"></a> [user\_password\_secret\_kms\_key\_id](#output\_user\_password\_secret\_kms\_key\_id) | The KMS key ID used to encrypt the secret containing the user password |
| <a name="output_username"></a> [username](#output\_username) | The username for the database |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where the RDS instance is deployed |
<!-- END_TF_DOCS -->