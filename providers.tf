# providers.tf
provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}


terraform {
required_version = "~> 1.0.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 1.0.4"
    }
  }
}
