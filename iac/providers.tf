terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "tech-challenge-bucket-state"
    region  = "us-east-1"
    key     = "database/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}
