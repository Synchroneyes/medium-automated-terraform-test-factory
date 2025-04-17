variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
  default     = ""
}

variable "security_group_description" {
  type        = string
  description = "Description of the security group."

  validation {
    condition     = length(var.security_group_description) >= 1 # To make the "fail" test fail
    error_message = "Security group description must be provided and must be at least 4 character long."
  }
}

variable "application_environment" {
  type        = string
  description = "The environment in which the application is running (e.g., dev, staging, prod)."
}

variable "application_name" {
  type        = string
  description = "The name of the application."
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of ingress rules for the security group."
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of egress rules for the security group."
}
