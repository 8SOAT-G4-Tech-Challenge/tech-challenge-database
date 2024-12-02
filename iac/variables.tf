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
  default     = "tech_challenge-postgres"
}

variable "state_bucket" {
  description = "S3 bucket with versioning enabled to store Terraform state"
  type        = string
  default     = "tech-challenge-database-bucket-state-tf"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_account_id" {
  type        = string
  description = "ID da conta AWS Lab Academy"
}