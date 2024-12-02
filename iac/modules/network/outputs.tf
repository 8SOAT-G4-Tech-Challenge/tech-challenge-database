output "database_vpc_id" {
	value = aws_vpc.database_vpc.id
	description = "ID da VPC criada para o banco de dados"
}

output "database_subnet_id" {
	value = aws_subnet.database_subnet.id
	description = "ID da Subnet criada para o banco de dados"
}