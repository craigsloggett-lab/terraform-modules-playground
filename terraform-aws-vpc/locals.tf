locals {
  region     = data.aws_region.current.region
  account_id = data.aws_caller_identity.current.account_id

  number_of_azs      = min(var.number_of_azs, length(data.aws_availability_zones.available.names))
  availability_zones = slice(data.aws_availability_zones.available.names, 0, local.number_of_azs)

  # Subnet calculations
  # Since VPC CIDR is enforced as /16, we always:
  # - Use 8 newbits to create /24 subnets (16 + 8 = 24)
  # - Have 256 possible /24 subnets (2^8)
  # - Use spacing to prevent overlap:
  #   * public:       indices 0-5     (up to 6 AZs)
  #   * private-app:  indices 10-15   (up to 6 AZs)
  #   * private-data: indices 100-105 (up to 6 AZs)
  public_subnets_calculated = var.public_subnet_cidrs != null ? var.public_subnet_cidrs : [
    for index in range(local.number_of_azs) : cidrsubnet(var.vpc_cidr, 8, index)
  ]

  private_app_subnets_calculated = var.private_app_subnet_cidrs != null ? var.private_app_subnet_cidrs : [
    for index in range(local.number_of_azs) : cidrsubnet(var.vpc_cidr, 8, 10 + index)
  ]

  private_data_subnets_calculated = var.private_data_subnet_cidrs != null ? var.private_data_subnet_cidrs : [
    for index in range(local.number_of_azs) : cidrsubnet(var.vpc_cidr, 8, 100 + index)
  ]

  public_subnet_names = [
    for index, az in local.availability_zones :
    "${var.vpc_name}-public-${az}"
  ]

  private_app_subnet_names = [
    for index, az in local.availability_zones :
    "${var.vpc_name}-private-app-${az}"
  ]

  private_data_subnet_names = [
    for index, az in local.availability_zones :
    "${var.vpc_name}-private-data-${az}"
  ]

  vpc_endpoint_services = {
    s3       = "com.amazonaws.${local.region}.s3"
    dynamodb = "com.amazonaws.${local.region}.dynamodb"
  }
}
