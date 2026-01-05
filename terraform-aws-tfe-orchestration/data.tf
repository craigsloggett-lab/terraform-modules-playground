data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "tfe" {
  name         = var.route53_zone_name
  private_zone = false
}

data "aws_vpc" "tfe" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tfe.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "private_app" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tfe.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private-app*"]
  }
}

data "aws_subnets" "private_data" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tfe.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private-data*"]
  }
}

data "aws_kms_key" "ssm" {
  key_id = "alias/aws/ssm"
}

data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-13-amd64-20251117-2299"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Create SSH key pair
resource "aws_key_pair" "this" {
  key_name   = "tfe-public-key"
  public_key = var.ssh_public_key
}

resource "random_string" "tfe_encryption_password" {
  length = 256
}

resource "random_string" "tfe_database_password" {
  length = 64
}
