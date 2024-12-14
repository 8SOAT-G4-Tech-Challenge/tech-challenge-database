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

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "region_default" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}