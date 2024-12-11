variable "aws_rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}
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
variable "aws_elastic_cache_endpoint" {
	description = "The endpoint of the Elastic Cache instance"
	type        = string
}