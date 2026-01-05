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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.alb_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the Application Load Balancer. If not provided, defaults to identifier. | `string` | `null` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the ALB. Typically ['0.0.0.0/0'] for internet-facing ALBs. | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group IDs allowed to access the ALB. | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the SSL certificate for the HTTPS listener. | `string` | n/a | yes |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time for the load balancer to wait before deregistering a target. | `number` | `300` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | Drop invalid HTTP header fields. Recommended for security. | `bool` | `true` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Enable cross-zone load balancing. | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection for the ALB. Recommended for production. | `bool` | `true` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Enable HTTP/2 for the ALB. | `bool` | `true` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | Enable health checks for the target group. | `bool` | `true` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy. | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The approximate amount of time, in seconds, between health checks of an individual target. | `number` | `30` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | The HTTP codes to use when checking for a successful response from a target. | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination for health checks on the targets. | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port to use for health checks. Use 'traffic-port' to use the same port as the target group. | `string` | `"traffic-port"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol to use for health checks. | `string` | `"HTTPS"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The amount of time, in seconds, during which no response means a failed health check. | `number` | `5` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | The number of consecutive health check failures required before considering a target unhealthy. | `number` | `10` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier for the ALB resources. Used to generate resource names if not explicitly provided. | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The time in seconds that the connection is allowed to be idle. | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether the load balancer is internal (private) or internet-facing (public). | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for the load balancer. Valid values are ipv4 or dualstack. | `string` | `"ipv4"` | no |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | The port on which the load balancer is listening. | `number` | `443` | no |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | The protocol for connections from clients to the load balancer. | `string` | `"HTTPS"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group. If not provided, defaults to '{identifier}-alb-sg'. | `string` | `null` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | The amount of time for targets to warm up before receiving their full share of requests. Set to 0 to disable. | `number` | `0` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | The name of the SSL policy for HTTPS listeners. See AWS documentation for available policies. | `string` | `"ELBSecurityPolicy-TLS13-1-2-2021-06"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the ALB. Should be public subnets across multiple AZs. | `list(string)` | n/a | yes |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | Name of the target group. If not provided, defaults to '{identifier}-tg'. | `string` | `null` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | The port on which targets receive traffic. | `number` | `443` | no |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | The protocol to use for routing traffic to the targets. | `string` | `"HTTPS"` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | The type of target. Valid values are instance, ip, or lambda. | `string` | `"instance"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the ALB will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the load balancer |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_alb_id"></a> [alb\_id](#output\_alb\_id) | The ID of the load balancer |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | The canonical hosted zone ID of the load balancer (for Route53 alias records) |
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | The ARN of the listener |
| <a name="output_listener_id"></a> [listener\_id](#output\_listener\_id) | The ID of the listener |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the ALB security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the ALB security group |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The ARN of the target group |
| <a name="output_target_group_arn_suffix"></a> [target\_group\_arn\_suffix](#output\_target\_group\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_target_group_id"></a> [target\_group\_id](#output\_target\_group\_id) | The ID of the target group |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | The name of the target group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where the ALB is deployed |
<!-- END_TF_DOCS -->