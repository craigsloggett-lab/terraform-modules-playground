module "terraform_aws_vpc" {
  source = "../../"

  vpc_name = "tfe-vpc-001"

  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}
