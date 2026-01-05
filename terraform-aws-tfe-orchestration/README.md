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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../../terraform-aws-alb | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | ../../terraform-aws-ec2-asg | n/a |
| <a name="module_cache"></a> [cache](#module\_cache) | ../../terraform-aws-elasticache | n/a |
| <a name="module_database"></a> [database](#module\_database) | ../../terraform-aws-rds-postgres | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ../../terraform-aws-tfe-iam | n/a |
| <a name="module_s3_storage"></a> [s3\_storage](#module\_s3\_storage) | app.terraform.io/craigsloggett-lab/s3-bucket/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.cert_validation_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ssm_parameter.postgresql_major_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_admin_token_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_database_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_database_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_database_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_database_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_encryption_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_hostname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_license](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_object_storage_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_object_storage_s3_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_redis_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_redis_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tfe_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_string.tfe_database_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.tfe_encryption_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ami.debian](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.private_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.private_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access TFE via the ALB. Use ['0.0.0.0/0'] for public access. | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Desired number of TFE instances in the Auto Scaling Group. If not specified, defaults to min\_size. | `number` | `null` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Maximum number of TFE instances in the Auto Scaling Group. | `number` | `4` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Minimum number of TFE instances in the Auto Scaling Group. | `number` | `2` | no |
| <a name="input_cache_engine"></a> [cache\_engine](#input\_cache\_engine) | The cache engine to use (redis or valkey). | `string` | `"valkey"` | no |
| <a name="input_cache_node_type"></a> [cache\_node\_type](#input\_cache\_node\_type) | The instance class for the ElastiCache nodes. | `string` | `"cache.t3.medium"` | no |
| <a name="input_database_allocated_storage"></a> [database\_allocated\_storage](#input\_database\_allocated\_storage) | The allocated storage in GB for the RDS database. | `number` | `64` | no |
| <a name="input_database_instance_class"></a> [database\_instance\_class](#input\_database\_instance\_class) | The instance class for the RDS PostgreSQL database. | `string` | `"db.t3.medium"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the PostgreSQL database. | `string` | `"tfe"` | no |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | The username for the PostgreSQL database. | `string` | `"tfeadmin"` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection for RDS and ALB. Set to false for non-production environments. | `bool` | `true` | no |
| <a name="input_force_destroy_s3"></a> [force\_destroy\_s3](#input\_force\_destroy\_s3) | Allow deletion of non-empty S3 bucket. Set to true only for non-production environments. | `bool` | `false` | no |
| <a name="input_instance_ami_id"></a> [instance\_ami\_id](#input\_instance\_ami\_id) | The AMI ID for TFE instances. If not provided, uses latest Debian 12. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The EC2 instance type for TFE application servers. | `string` | `"t3.large"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (e.g., 'tfe' or 'tfe-prod'). Used to generate consistent names across all resources. | `string` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | The Route53 hosted zone name for TFE (e.g., 'example.com'). Must be an existing hosted zone. | `string` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Skip final RDS snapshot on deletion. Set to true for non-production environments. | `bool` | `false` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The name of an existing EC2 key pair for SSH access to instances. If not provided, instances won't have SSH access. | `string` | n/a | yes |
| <a name="input_tfe_license"></a> [tfe\_license](#input\_tfe\_license) | The TFE license string. | `string` | n/a | yes |
| <a name="input_tfe_subdomain"></a> [tfe\_subdomain](#input\_tfe\_subdomain) | The subdomain for TFE (e.g., 'tfe'). If null, uses the root domain. Final hostname will be subdomain.zone\_name or just zone\_name. | `string` | `"tfe"` | no |
| <a name="input_tfe_version"></a> [tfe\_version](#input\_tfe\_version) | The version of TFE to deploy (e.g., 'v202501-1'). | `string` | `"1.1.2"` | no |
| <a name="input_user_data_script"></a> [user\_data\_script](#input\_user\_data\_script) | Custom user data script for TFE instances. If not provided, uses a default startup script. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_alb_security_group_id"></a> [alb\_security\_group\_id](#output\_alb\_security\_group\_id) | The ID of the ALB security group |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | The zone ID of the load balancer |
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | The ARN of the Auto Scaling Group |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | The name of the Auto Scaling Group |
| <a name="output_cache_auth_token"></a> [cache\_auth\_token](#output\_cache\_auth\_token) | The auth token for the cache cluster |
| <a name="output_cache_primary_endpoint"></a> [cache\_primary\_endpoint](#output\_cache\_primary\_endpoint) | The primary endpoint for the cache cluster |
| <a name="output_cache_security_group_id"></a> [cache\_security\_group\_id](#output\_cache\_security\_group\_id) | The ID of the cache security group |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | The ARN of the ACM certificate |
| <a name="output_database_address"></a> [database\_address](#output\_database\_address) | The hostname of the database |
| <a name="output_database_endpoint"></a> [database\_endpoint](#output\_database\_endpoint) | The connection endpoint for the database |
| <a name="output_database_password_secret_arn"></a> [database\_password\_secret\_arn](#output\_database\_password\_secret\_arn) | The ARN of the secret containing the database password |
| <a name="output_database_security_group_id"></a> [database\_security\_group\_id](#output\_database\_security\_group\_id) | The ID of the database security group |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role |
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | The ARN of the IAM instance profile |
| <a name="output_instance_security_group_id"></a> [instance\_security\_group\_id](#output\_instance\_security\_group\_id) | The ID of the instance security group |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the S3 bucket for TFE object storage |
| <a name="output_ssm_parameter_path"></a> [ssm\_parameter\_path](#output\_ssm\_parameter\_path) | The prefix path for SSM parameters |
| <a name="output_tfe_hostname"></a> [tfe\_hostname](#output\_tfe\_hostname) | The hostname of the TFE installation |
| <a name="output_tfe_url"></a> [tfe\_url](#output\_tfe\_url) | The URL to access Terraform Enterprise |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->