variable "redis_node_type" {
  description = "Tipo de nó para o cluster Redis"
  default     = "cache.t3.micro"
}

variable "allowed_cidr_blocks" {
  description = "Blocos CIDR permitidos para acessar o Redis"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "elastic_cache_vars" {
	description = "Variáveis do banco de dados"
	type        = map(string)
	default 	 = {}
}

variable "vpcCidr" {
  default = "172.31.0.0/16"
}