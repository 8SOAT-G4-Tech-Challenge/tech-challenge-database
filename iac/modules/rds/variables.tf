variable "engine" {
  description = "The database engine"
  type = string
  default = "postgres"
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
variable "instance_class" {
  description = "The RDS instance class"
  default = "db.t3.micro"
  type = string
}
variable "engine_version" {
  description = "The engine version"
  default = "16"
  type = number
}
variable "skip_final_snapshot" {
  description = "skip snapshot"
  default = "true"
  type = string
}
variable "identifier" {
  description = "The name of the RDS instance"
  default = "tech-challenge-database"
  type = string
}
variable "port" {
  description = "The port on which the DB accepts connections"
  default = "5432"
  type = number
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

variable "main_vpc_id" {
	description = "The ID of the VPC"
	type        = string
}

variable "database_subnet_ids" {
  description = "Subnets para o Redis"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "Blocos CIDR permitidos para acessar o Redis"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}