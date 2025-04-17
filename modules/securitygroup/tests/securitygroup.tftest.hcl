provider "aws" {
  region = "eu-west-1"
}

run "plan" {

  command = plan

  module {
    source = "./"
  }

  variables {
    application_environment    = "dev"
    application_name           = "test-app-sg"
    security_group_description = "Security group for test"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  assert {
    condition     = aws_security_group.security_group.tags_all["Name"] == "test-app-sg-dev-sg"
    error_message = "Security Group Name tag should be test-app-sg-dev-sg"
  }
}


run "apply" {

  command = apply

  module {
    source = "./"
  }

  variables {
    application_environment    = "dev"
    application_name           = "test-app-sg"
    security_group_description = "Security group for test"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  assert {
    condition     = aws_security_group.security_group.tags_all["Name"] == "test-app-sg-dev-sg"
    error_message = "Security Group Name tag should be test-app-sg-dev-sg"

  }

  assert {
    condition     = var.ingress_rules[0].from_port == 80
    error_message = "Security Group Ingress Rule from_port should be 80"
  }

  assert {
    condition     = var.ingress_rules[0].to_port == 80
    error_message = "Security Group Ingress Rule to_port should be 80"
  }

  assert {
    condition     = var.ingress_rules[0].protocol == "tcp"
    error_message = "Security Group Ingress Rule protocol should be tcp"
  }

  assert {
    condition     = var.ingress_rules[0].cidr_blocks[0] == "10.0.0.0/16"
    error_message = "Security Group Ingress Rule cidr_blocks should be 10.0.0.0/16"
  }

  assert {
    condition     = var.egress_rules[0].from_port == 0
    error_message = "Security Group Egress Rule from_port should be 0"
  }

  assert {
    condition     = var.egress_rules[0].to_port == 0
    error_message = "Security Group Egress Rule to_port should be 0"
  }

  assert {
    condition     = var.egress_rules[0].protocol == "-1"
    error_message = "Security Group Egress Rule protocol should be -1"
  }

  assert {
    condition     = var.egress_rules[0].cidr_blocks[0] == "0.0.0.0/0"
    error_message = "Security Group Egress Rule cidr_blocks should contains 0.0.0.0/0"
  }

}

run "description_validation_should_fail" {

  command = plan

  module {
    source = "./"
  }

  variables {
    application_environment    = "dev"
    application_name           = "test-app-sg"
    security_group_description = "sg"
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress_rules = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  expect_failures = [
    var.security_group_description
  ]

}

