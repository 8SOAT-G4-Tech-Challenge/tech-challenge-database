variable "db_postgres_username" {
  description = "The username of the database"
  type        = string
}
variable "db_postgres_password" {
  description = "The password of the database"
  type        = string
}
variable "db_postgres_database" {
  description = "The name of the database"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket with versioning enabled to store Terraform state"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "region_default" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "ID da conta AWS Lab Academy"
  type        = string
}