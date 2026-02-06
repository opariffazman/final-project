terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket  = "s3-terraform-bucket-sg"
    key     = "terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "terraform-user"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "ap-southeast-1"
  profile = "terraform-user"
}

