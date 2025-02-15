variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
}

variable "cloud_provider" {
  type        = string
  description = "AWS or GCP or Azure"
}

variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

variable "mongodb_version" {
  type        = string
  default     = "8.0"
  description = "MongoDB Version"
}

variable "ip_address" {
  type        = string
  description = "IP address used to access Atlas cluster"
}

variable "db_mongo_username" {
  description = "The username of the database"
  type        = string
}