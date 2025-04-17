### PROVISION VPC AND SUBNETS ###
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name        = "${var.application_name}-${var.application_environment}-vpc"
    Environment = var.application_environment
    Application = var.application_name
  }
}



