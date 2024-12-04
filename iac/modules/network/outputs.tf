output "main_vpc_id" {
	value = aws_vpc.main_vpc.id
	description = "ID da VPC principal"
}

output "private_subnet_id" {
	value = aws_subnet.private_subnet[*].id
	description = "ID da Subnet criada para o banco de dados"
}

/* output "eks_security_group_id" {
	value = aws_security_group.eks_access.id
	description = "ID do Security Group para o EKS"
} */