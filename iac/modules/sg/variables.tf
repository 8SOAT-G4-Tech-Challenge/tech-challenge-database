variable "project_name" {
  description = "Project name"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "allowed_cidr_blocks" {
  description = "Blocos CIDR permitidos para acessar o Redis"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = list(string)
  default     = ["192.168.0.0/16"]
}