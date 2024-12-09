# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-igw"
		Iac = true
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "192.168.0.0/20"
  availability_zone = "${var.region_default}a"

  tags = {
    Name = "${var.project_name}-private-subnet-1"
		"kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
		Iac = true
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "192.168.32.0/20"
  availability_zone = "${var.region_default}b"

  tags = {
    Name = "${var.project_name}-private-subnet-2"
		"kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
		Iac = true
  }
}

resource "aws_subnet" "public_subnet_1" {
	vpc_id            = var.vpc_id
	cidr_block        = "192.168.64.0/20"
	availability_zone = "${var.region_default}a"
	map_public_ip_on_launch = true

	tags = {
		Name = "${var.project_name}-public-subnet-1"
		"kubernetes.io/role/elb" = "1"
		"kubernetes.io/cluster/demo" = "owned"
		Iac = true
	}
}

resource "aws_subnet" "public_subnet_2" {
	vpc_id            = var.vpc_id
	cidr_block        = "192.168.96.0/20"
	availability_zone = "${var.region_default}b"
	map_public_ip_on_launch = true

	tags = {
		Name = "${var.project_name}-public-subnet-2"
		"kubernetes.io/role/elb" = "1"
		"kubernetes.io/cluster/demo" = "owned"
		Iac = true
	}
}

# Create NAT Gateway (requires public subnet and EIP)
resource "aws_eip" "nat" {
  domain = "vpc"

	tags = {
		Name = "${var.project_name}-nat-eip"
		Iac = true
	}
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.project_name}-k8s-nat-gateway"
		Iac = true
  }

	depends_on = [aws_internet_gateway.main]
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    # nat_gateway_id = aws_nat_gateway.k8s-nat.id
		gateway_id     = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
		Iac = true
  }
}

# Create route table for public subnets
resource "aws_route_table" "public" {
	vpc_id = var.vpc_id

	route {
      cidr_block	= "0.0.0.0/0"
      gateway_id	= aws_internet_gateway.main.id
    }

  tags = {
    Name = "${var.project_name}-public-rt"
		Iac = true
  }
}

# Associate route table
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_1" {
	subnet_id      = aws_subnet.public_subnet_1.id
	route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
	subnet_id      = aws_subnet.public_subnet_2.id
	route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "database" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
		Iac = true
  }
}

resource "aws_elasticache_subnet_group" "cache" {
  name       = "${var.project_name}-cache-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "${var.project_name}-cache-subnet-group"
		Iac = true
  }
}