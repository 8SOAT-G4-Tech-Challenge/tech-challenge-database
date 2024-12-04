variable "network_vars" {
	description = "Network variables"
	type        = map(string)
	default     = {}
}

/* variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
} */

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

/* variable "eks_security_group_id" {
  description = "Security Group ID from EKS cluster"
  type        = string
} */