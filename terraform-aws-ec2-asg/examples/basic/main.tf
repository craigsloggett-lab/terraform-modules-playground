data "aws_vpc" "tfe" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tfe.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private-app*"]
  }
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

module "terraform_aws_ec2_asg" {
  source = "../../"

  identifier = "tfe"
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private.ids
  ami_id     = data.aws_ami.debian.id

  # Instance Configuration
  instance_type            = "t3.large"
  aws_key_pair_name        = aws_key_pair.this.key_name
  iam_instance_profile_arn = var.iam_instance_profile_arn
  user_data                = data.template_file.user_data.rendered

  # Root Volume
  root_volume_type       = "gp3"
  root_volume_size       = 50
  root_volume_iops       = 3000
  root_volume_throughput = 125

  # Metadata Options (IMDSv2)
  http_tokens   = "required"
  http_endpoint = "enabled"

  # Monitoring
  enable_monitoring = true
  ebs_optimized     = true

  # Auto Scaling Group
  min_size                  = 0
  max_size                  = 2
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Target Group
  target_group_arns = [var.target_group_arn]

  # Custom ingress rules
  ingress_rules = [
    {
      description = "Allow HTTPS traffic ingress to the TFE Hosts from all networks."
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
    },
    {
      description = "Allow SSH traffic ingress to the TFE Hosts from private subnets."
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    },
    {
      description = "Allow Vault traffic ingress to the TFE Hosts from private subnets."
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 8201
      to_port     = 8201
    }
  ]
}
