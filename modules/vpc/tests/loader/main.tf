provider "aws" {
  region = "eu-west-1"
}


data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["test-app-dev-vpc"]
  }
}
