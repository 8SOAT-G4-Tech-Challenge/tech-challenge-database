terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "default" # Profile name in the credentials file
  region  = "us-east-1"   # Region to deploy the resources
}
