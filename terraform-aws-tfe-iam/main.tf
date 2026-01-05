resource "aws_iam_role" "tfe" {
  name               = local.role_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.tfe_assume_role.json
}

data "aws_iam_policy_document" "tfe_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

# Modify EC2 metadata.

data "aws_iam_policy_document" "ec2_modify_metadata" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:ModifyInstanceMetadataOptions"
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:instance/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_modify_metadata" {
  name   = "EC2ModifyInstanceMetadataOptions"
  path   = "/"
  policy = data.aws_iam_policy_document.ec2_modify_metadata.json
}

resource "aws_iam_role_policy_attachment" "ec2_modify_metadata" {
  role       = aws_iam_role.tfe.name
  policy_arn = aws_iam_policy.ec2_modify_metadata.arn
}

# Get parameters from the SSM Parameter Store.

data "aws_iam_policy_document" "tfe_get_parameters" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:PutParameter",
      "ssm:DescribeParameters"
    ]
    resources = var.ssm_parameter_arns
  }
}

resource "aws_iam_policy" "tfe_get_parameters" {
  name   = "SSMReadTerraformEnterpriseParameters"
  path   = "/"
  policy = data.aws_iam_policy_document.tfe_get_parameters.json
}

resource "aws_iam_role_policy_attachment" "tfe_get_parameters" {
  role       = aws_iam_role.tfe.name
  policy_arn = aws_iam_policy.tfe_get_parameters.arn
}

# Get secrets from Secrets Manager.

data "aws_iam_policy_document" "tfe_secrets_manager" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = var.secrets_manager_secret_arns
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:ListSecrets"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "tfe_secrets_manager" {
  name   = "SecretsManagerReadTerraformEnterpriseSecrets"
  path   = "/"
  policy = data.aws_iam_policy_document.tfe_secrets_manager.json
}

resource "aws_iam_role_policy_attachment" "tfe_secrets_manager" {
  role       = aws_iam_role.tfe.name
  policy_arn = aws_iam_policy.tfe_secrets_manager.arn
}

# Allow full access to the TFE S3 bucket.

data "aws_iam_policy_document" "tfe_s3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      data.aws_s3_bucket.tfe.arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:*Object"
    ]
    resources = [
      "${data.aws_s3_bucket.tfe.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "tfe_s3" {
  name   = "S3WriteTerraformEnterpriseBucket"
  path   = "/"
  policy = data.aws_iam_policy_document.tfe_s3.json
}

resource "aws_iam_role_policy_attachment" "tfe_s3" {
  role       = aws_iam_role.tfe.name
  policy_arn = aws_iam_policy.tfe_s3.arn
}

# Create an EC2 instance profile using the TFE role.

resource "aws_iam_instance_profile" "tfe" {
  name = local.instance_profile_name
  path = "/"
  role = aws_iam_role.tfe.name
}
