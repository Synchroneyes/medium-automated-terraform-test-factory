output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "vpc_name" {
  description = "The name of the VPC."
  value       = aws_vpc.vpc.tags_all["Name"]
}

output "vpc_enable_dns_support" {
  description = "Whether DNS support is enabled in the VPC."
  value       = aws_vpc.vpc.enable_dns_support
}

output "vpc_enable_dns_hostnames" {
  description = "Whether DNS hostnames are enabled in the VPC."
  value       = aws_vpc.vpc.enable_dns_hostnames
}
output "vpc_tags" {
  description = "The tags associated with the VPC."
  value       = aws_vpc.vpc.tags
}
