terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 6"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}