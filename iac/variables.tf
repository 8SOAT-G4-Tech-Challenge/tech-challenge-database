variable "tc_order_db_postgres_username" {
  description = "The username of the database"
  type        = string
}
variable "tc_order_db_postgres_password" {
  description = "The password of the database"
  type        = string
}
variable "tc_order_db_postgres_database" {
  description = "The name of the database"
  type        = string
}

variable "tc_user_db_postgres_username" {
  description = "The username of the database"
  type        = string
}
variable "tc_user_db_postgres_password" {
  description = "The password of the database"
  type        = string
}
variable "tc_user_db_postgres_database" {
  description = "The name of the database"
  type        = string
}

variable "default_project_name" {
  description = "Project name"
  default     = "tech-challenge"
  type        = string
}

variable "region_default" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "tc_payment_atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "tc_payment_atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "tc_payment_atlas_cluster_instance_size_name" {
  type        = string
  default     = "M0"
  description = "Cluster instance size name"
}

variable "tc_payment_atlas_cloud_provider" {
  type        = string
  default     = "AWS"
  description = "AWS or GCP or Azure"
}

variable "tc_payment_atlas_ip_address" {
  type        = string
  description = "IP address used to access Atlas cluster"
}

variable "tc_payment_db_mongo_username" {
  description = "The username of the database"
  type        = string
}
variable "tc_payment_db_mongo_password" {
  description = "The password of the database"
  type        = string
}
variable "tc_order_project_name" {
  description = "The tech-challenge-order project name"
  default     = "tech-challenge-order"
  type        = string
}
variable "tc_user_project_name" {
  description = "The tech-challenge-user project name"
  default     = "tech-challenge-user"
  type        = string
}
variable "tc_payment_project_name" {
  description = "The tech-challenge-payment project name"
  default     = "tech-challenge-payment"
  type        = string
}