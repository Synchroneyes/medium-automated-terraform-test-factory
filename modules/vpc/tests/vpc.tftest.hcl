provider "aws" {
  region = "eu-west-1"
}

run "plan" {

  command = plan

  module {
    source = "./"
  }

  variables {
    application_environment = "dev"
    application_name        = "test-app"
    vpc_cidr_block          = "10.0.0.0/16"
    enable_dns_support      = true
    enable_dns_hostnames    = true
  }

  assert {
    condition     = aws_vpc.vpc.enable_dns_hostnames == true
    error_message = "DNS hostnames should be enabled in the VPC."
  }

  assert {
    condition     = aws_vpc.vpc.enable_dns_support == true
    error_message = "DNS Support should be enabled in the VPC."
  }

  assert {
    condition     = aws_vpc.vpc.tags_all["Name"] == "test-app-dev-vpc"
    error_message = "VPC Name tag should be test-app-dev-vpc"
  }

}

run "apply" {
  command = apply

  module {
    source = "./"
  }

  variables {
    application_environment = "dev"
    application_name        = "test-app"
    vpc_cidr_block          = "10.0.0.0/16"
    enable_dns_support      = true
    enable_dns_hostnames    = true
  }
}

run "verify" {
  module {
    source = "./tests/loader"
  }

  variables {
    application_environment = "dev"
    application_name        = "test-app"
  }

  assert {
    condition     = data.aws_vpc.vpc.enable_dns_support == true
    error_message = "DNS hostnames should be enabled in the VPC."
  }

  assert {
    condition     = data.aws_vpc.vpc.enable_dns_hostnames == true
    error_message = "DNS Support should be enabled in the VPC."
  }

}

