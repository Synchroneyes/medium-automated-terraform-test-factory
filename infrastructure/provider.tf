terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "your_bucket_name"
    key    = "terraform.tfstate"
    region = "your_aws_region"
  }
}

provider "aws" {
  region = "your_aws_region"
}
