module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  # VPC Basic Configuration
  name = var.vpc_name
  cidr = var.vpc_cidr

  # Availability Zones and Subnets
  azs = local.availability_zones

  # Public Subnets (ALB, NAT Gateway, Bastion)
  public_subnets      = local.public_subnets_calculated
  public_subnet_names = local.public_subnet_names

  # Private Application Subnets (EC2, ECS, Lambda)
  private_subnets      = local.private_app_subnets_calculated
  private_subnet_names = local.private_app_subnet_names

  # Private Database Subnets (RDS, ElastiCache, Redshift)
  database_subnets             = local.private_data_subnets_calculated
  database_subnet_names        = local.private_data_subnet_names
  create_database_subnet_group = var.create_database_subnet_groups

  # DNS Configuration
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # NAT Gateway Configuration
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway && !var.one_nat_gateway_per_az
  one_nat_gateway_per_az = var.one_nat_gateway_per_az && !var.single_nat_gateway

  # Network ACLs
  manage_default_network_acl = var.manage_default_network_acl
  default_network_acl_ingress = [
    for rule in var.default_network_acl_ingress : {
      rule_no    = rule.rule_no
      action     = rule.action
      from_port  = rule.from_port
      to_port    = rule.to_port
      protocol   = rule.protocol
      cidr_block = rule.cidr_block
    }
  ]
  default_network_acl_egress = [
    for rule in var.default_network_acl_egress : {
      rule_no    = rule.rule_no
      action     = rule.action
      from_port  = rule.from_port
      to_port    = rule.to_port
      protocol   = rule.protocol
      cidr_block = rule.cidr_block
    }
  ]

  # VPC Flow Logs
  enable_flow_log                                 = var.enable_flow_log
  create_flow_log_cloudwatch_iam_role             = var.enable_flow_log
  create_flow_log_cloudwatch_log_group            = var.enable_flow_log
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_logs_retention_days
  flow_log_traffic_type                           = var.flow_logs_traffic_type
}
