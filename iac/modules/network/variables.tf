variable "project_name" {
  description = "Project name"
  type        = string
}
variable "region_default" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "vpc_id" {
	description = "VPC ID"
}