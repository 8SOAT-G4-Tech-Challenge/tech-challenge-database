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
  default     = "tech-challenge-database-bucket-state-tf"
}