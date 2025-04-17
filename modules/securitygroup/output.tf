output "sg_name" {
  description = "The name of the security group."
  value       = aws_security_group.security_group.tags_all["Name"]
}

output "sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.security_group.id
}

output "sg_vpc_id" {
  description = "The VPC ID of the security group."
  value       = aws_security_group.security_group.vpc_id
}

output "sg_ingress_rules" {
  description = "The ingress rules of the security group."
  value       = var.ingress_rules
}

output "sg_egress_rules" {
  description = "The egress rules of the security group."
  value       = var.egress_rules
}
