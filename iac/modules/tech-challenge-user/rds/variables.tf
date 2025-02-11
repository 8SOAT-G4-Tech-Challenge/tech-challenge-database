variable "project_name" {
  description = "Project name"
  default     = "tech-challenge-user"
  type        = string
}
variable "allocated_storage" {
  description = "The amount of allocated storage."
  type = number
  default = 20
}
variable "storage_type" {
  description = "type of the storage"
  type = string
  default = "gp2"
}
variable "engine" {
  description = "The database engine"
  type = string
  default = "postgres"
}
variable "engine_version" {
  description = "The engine version"
  default = "16"
  type = number
}
variable "instance_class" {
  description = "The RDS instance class"
  default = "db.t3.micro"
  type = string
}
variable "db_postgres_database" {
	description = "The name of the database"
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
variable "port" {
  description = "The port on which the DB accepts connections"
  default = "5432"
  type = number
}
variable "identifier" {
  description = "The name of the RDS instance"
  default = "tech-challenge-user-database"
  type = string
}
variable "skip_final_snapshot" {
  description = "skip snapshot"
  default = "true"
  type = string
}
variable "db_subnet_group_name" {
	description = "Database subnet group name"
	type = string
}
variable "security_group_id" {
	description = "Security group ID"
	type = string
}

variable "parameter_group_name" {
  description = "Parameter group name"
	type = string
}