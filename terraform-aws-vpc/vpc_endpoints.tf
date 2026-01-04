resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = local.vpc_endpoint_services.s3
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${var.vpc_name}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_public" {
  route_table_id  = module.vpc.public_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_app" {
  route_table_id  = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_data" {
  route_table_id  = module.vpc.database_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = module.vpc.vpc_id
  service_name      = local.vpc_endpoint_services.dynamodb
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${var.vpc_name}-dynamodb-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_public" {
  route_table_id  = module.vpc.public_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_app" {
  route_table_id  = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_data" {
  route_table_id  = module.vpc.database_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}
