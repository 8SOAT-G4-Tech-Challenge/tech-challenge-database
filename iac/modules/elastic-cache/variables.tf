variable "redis_node_type" {
  description = "Tipo de nó para o cluster Redis"
  default     = "cache.t3.micro"
}

variable "allowed_cidr_blocks" {
  description = "Blocos CIDR permitidos para acessar o Redis"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "database_subnet_ids" {
  description = "Subnets para o Redis"
  type        = list(string)
}

variable "main_vpc_id" {
	description = "ID da VPC"
	type        = string
}

variable "elastic_cache_vars" {
	description = "Variáveis do banco de dados"
	type        = map(string)
	default 	 = {}
}