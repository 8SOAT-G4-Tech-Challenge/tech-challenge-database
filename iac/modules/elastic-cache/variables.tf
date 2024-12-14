variable "project_name" {
  description = "Project name"
  type        = string
}
variable "redis_node_type" {
  description = "Tipo de nó para o cluster Redis"
  default     = "cache.t3.micro"
}
variable "subnet_group_name" {
	description = "Cache subnet group name"
	type = string
}
variable "security_group_id" {
	description = "Security group ID"
	type = string
}