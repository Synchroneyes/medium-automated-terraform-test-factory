resource "aws_security_group" "security_group" {
  name        = "${var.application_name}-${var.application_environment}-sg"
  description = var.security_group_description
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default_vpc.id

  tags = {
    Name        = "${var.application_name}-${var.application_environment}-sg"
    Environment = var.application_environment
    Application = var.application_name
  }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
