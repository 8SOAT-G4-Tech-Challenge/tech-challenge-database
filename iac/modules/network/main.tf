resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-vpc"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}

resource "aws_subnet" "database_subnet" {
	count = 2
  vpc_id            = aws_vpc.main_vpc.id
	cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  # cidr_block        = "10.0.0.0/24"
  # availability_zone = "${var.network_vars["aws_region"]}a"

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-subnet-${count.index+1}"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}