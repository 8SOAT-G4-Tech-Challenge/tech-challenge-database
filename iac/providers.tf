terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
  backend "s3" {
    bucket  = "tech-challenge-bucket-state-tf"
    region  = "us-east-1"
    key     = "database/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "mongodbatlas" {
  public_key  = "ewgcrwya"
  private_key = "79641880-003d-4deb-a901-3719157dfe49"
}