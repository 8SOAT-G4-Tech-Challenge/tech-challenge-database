resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
	enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-vpc"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}

# Security Group for EKS
# resource "aws_security_group" "eks_access" {
#   name        = "${var.network_vars["project_name"]}-eks-access-sg"
#   description = "Security group for EKS access to databases"
#   vpc_id      = aws_vpc.main_vpc.id

#   tags = {
#     Name        = "${var.network_vars["project_name"]}-eks-access-sg"
#     Environment = var.network_vars["environment"]
#     Iac         = true
#   }
# }

# Rule for Redis access
# resource "aws_security_group_rule" "eks_to_redis" {
#   type                     = "ingress"
#   from_port               = 6379  # Redis port
#   to_port                 = 6379
#   protocol                = "tcp"
#   security_group_id       = aws_security_group.eks_access.id
#   source_security_group_id = var.eks_security_group_id
# }

# Rule for PostgreSQL access
# resource "aws_security_group_rule" "eks_to_postgres" {
#   type                     = "ingress"
#   from_port               = 5432  # PostgreSQL port
#   to_port                 = 5432
#   protocol                = "tcp"
#   security_group_id       = aws_security_group.eks_access.id
#   source_security_group_id = var.eks_security_group_id
# }

resource "aws_subnet" "private_subnet" {
	count 						= 2
  vpc_id            = aws_vpc.main_vpc.id
	cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-subnet-${count.index + 1}"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}

# resource "aws_subnet" "eks_subnet" {
#   count             = 2
#   vpc_id            = aws_vpc.main_vpc.id
#   cidr_block        = "10.0.${count.index + 1}.0/24"
#   availability_zone = var.availability_zones[count.index]

#   tags = {
#     Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-subnet-${count.index + 1}"
# 		Environment = var.network_vars["environment"]
# 		Iac = true
#   }
# }

resource "aws_security_group" "vpc_endpoints" {
  name        = "vpc-endpoints-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
}

resource "aws_vpc_endpoint" "lambda" {
  vpc_id             = aws_vpc.main_vpc.id
  service_name       = "com.amazonaws.${var.network_vars["aws_region"]}.lambda"
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = aws_subnet.private_subnet[*].id
}