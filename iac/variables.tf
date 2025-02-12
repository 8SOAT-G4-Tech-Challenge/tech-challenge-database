variable "tech_challenge_order_db_postgres_username" {
  description = "The username of the database"
  type        = string
}
variable "tech_challenge_order_db_postgres_password" {
  description = "The password of the database"
  type        = string
}
variable "tech_challenge_order_db_postgres_database" {
  description = "The name of the database"
  type        = string
}

variable "tech_challenge_user_db_postgres_username" {
  description = "The username of the database"
  type        = string
}
variable "tech_challenge_user_db_postgres_password" {
  description = "The password of the database"
  type        = string
}
variable "tech_challenge_user_db_postgres_database" {
  description = "The name of the database"
  type        = string
}

variable "default_project_name" {
  description = "Project name"
  type        = string
}

variable "region_default" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "tech_challenge_payment_atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "tech_challenge_payment_atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "tech_challenge_payment_atlas_environment" {
  type        = string
  description = "The environment to be built"
}

variable "tech_challenge_payment_atlas_cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
}

variable "tech_challenge_payment_atlas_cloud_provider" {
  type        = string
  description = "AWS or GCP or Azure"
}

variable "tech_challenge_payment_atlas_ip_address" {
  type = string
  description = "IP address used to access Atlas cluster"
}

variable "tech_challenge_payment_db_postgres_username" {
	description = "The username of the database"
	type        = string
}
variable "tech_challenge_payment_db_postgres_password" {
	description = "The password of the database"
	type        = string
}