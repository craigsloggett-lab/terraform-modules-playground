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
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The AMI ID to use for the launch template. | `string` | n/a | yes |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of the Auto Scaling Group. If not provided, defaults to '{identifier}-asg'. | `string` | `null` | no |
| <a name="input_aws_key_pair_name"></a> [aws\_key\_pair\_name](#input\_aws\_key\_pair\_name) | The key name to use for SSH access. If not provided, instances will not have SSH access. | `string` | `null` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | The amount of time, in seconds, after a scaling activity completes before another can begin. | `number` | `300` | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether the root volume should be destroyed on instance termination. | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The desired capacity of the Auto Scaling Group. If not specified, defaults to min\_size. | `number` | `null` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Enable EBS optimization for the instance. | `bool` | `true` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enable detailed monitoring (1-minute intervals). Incurs additional charges. | `bool` | `true` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | List of metrics to collect for the Auto Scaling Group. | `list(string)` | <pre>[<br/>  "GroupMinSize",<br/>  "GroupMaxSize",<br/>  "GroupDesiredCapacity",<br/>  "GroupInServiceInstances",<br/>  "GroupPendingInstances",<br/>  "GroupStandbyInstances",<br/>  "GroupTerminatingInstances",<br/>  "GroupTotalInstances"<br/>]</pre> | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health. | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | The type of health check. Valid values are EC2 or ELB. | `string` | `"ELB"` | no |
| <a name="input_http_endpoint"></a> [http\_endpoint](#input\_http\_endpoint) | Enable or disable the HTTP metadata endpoint on instances. | `string` | `"enabled"` | no |
| <a name="input_http_put_response_hop_limit"></a> [http\_put\_response\_hop\_limit](#input\_http\_put\_response\_hop\_limit) | The desired HTTP PUT response hop limit for instance metadata requests. | `number` | `1` | no |
| <a name="input_http_tokens"></a> [http\_tokens](#input\_http\_tokens) | Whether or not the metadata service requires session tokens (IMDSv2). Set to 'required' for IMDSv2. | `string` | `"required"` | no |
| <a name="input_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#input\_iam\_instance\_profile\_arn) | The ARN of the IAM instance profile to attach to instances. | `string` | `null` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier for the ASG resources. Used to generate resource names if not explicitly provided. | `string` | n/a | yes |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules for the security group. | <pre>list(object({<br/>    description = string<br/>    cidr_ipv4   = string<br/>    ip_protocol = string<br/>    from_port   = number<br/>    to_port     = number<br/>  }))</pre> | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use for the launch template. | `string` | `"t3.medium"` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of the launch template. If not provided, defaults to '{identifier}-lt'. | `string` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the Auto Scaling Group. | `number` | `4` | no |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | The granularity to associate with the metrics to collect. | `string` | `"1Minute"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the Auto Scaling Group. | `number` | `2` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Whether newly launched instances are protected from scale in. | `bool` | `false` | no |
| <a name="input_root_volume_iops"></a> [root\_volume\_iops](#input\_root\_volume\_iops) | The amount of provisioned IOPS for the root volume. Required for io1, io2, and gp3 volume types. | `number` | `3000` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | The size of the root volume in GB. | `number` | `50` | no |
| <a name="input_root_volume_throughput"></a> [root\_volume\_throughput](#input\_root\_volume\_throughput) | The throughput for the root volume in MB/s. Only valid for gp3 volumes. | `number` | `125` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | The type of root volume. Can be standard, gp2, gp3, io1, io2, sc1, or st1. | `string` | `"gp3"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group. If not provided, defaults to '{identifier}-sg'. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the Auto Scaling Group. Should be private subnets across multiple AZs. | `list(string)` | n/a | yes |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | List of target group ARNs to attach to the Auto Scaling Group. | `list(string)` | `[]` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | A list of policies to decide how the instances in the Auto Scaling Group should be terminated. | `list(string)` | <pre>[<br/>  "Default"<br/>]</pre> | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Will be base64 encoded automatically. | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | The base64-encoded user data to provide when launching the instance. Use this if you want to provide pre-encoded user data. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the instances will be deployed. | `string` | n/a | yes |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | Maximum duration to wait for all instances to be healthy in the ASG. | `string` | `"10m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN of the Auto Scaling Group |
| <a name="output_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#output\_autoscaling\_group\_desired\_capacity) | The desired capacity of the Auto Scaling Group |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The ID of the Auto Scaling Group |
| <a name="output_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#output\_autoscaling\_group\_max\_size) | The maximum size of the Auto Scaling Group |
| <a name="output_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#output\_autoscaling\_group\_min\_size) | The minimum size of the Auto Scaling Group |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the Auto Scaling Group |
| <a name="output_launch_template_arn"></a> [launch\_template\_arn](#output\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_launch_template_default_version"></a> [launch\_template\_default\_version](#output\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | The ID of the launch template |
| <a name="output_launch_template_latest_version"></a> [launch\_template\_latest\_version](#output\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the instance security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the instance security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where instances are deployed |
<!-- END_TF_DOCS -->