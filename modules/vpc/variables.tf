variable "application_environment" {
  type        = string
  description = "The environment in which the application is running (e.g., dev, staging, prod)."
}

variable "application_name" {
  type        = string
  description = "The name of the application."

}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "enable_dns_support" {
  type        = bool
  default     = false
  description = "Enable DNS support in the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "Enable DNS hostnames in the VPC."

}
