resource "aws_vpc" "database_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-vpc"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}

resource "aws_subnet" "database_subnet" {
  vpc_id            = aws_vpc.database_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.network_vars["aws_region"]}a"

  tags = {
    Name = "${var.network_vars["project_name"]}-${var.network_vars["environment"]}-subnet"
		Environment = var.network_vars["environment"]
		Iac = true
  }
}