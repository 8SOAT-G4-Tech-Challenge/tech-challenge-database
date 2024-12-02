output "main_vpc_id" {
	value = aws_vpc.main_vpc.id
	description = "ID da VPC principal"
}

output "database_subnet_id" {
	value = aws_subnet.database_subnet[*].id
	description = "ID da Subnet criada para o banco de dados"
}