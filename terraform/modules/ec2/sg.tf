####################### SECURITY GROUP #######################
resource "aws_security_group" "ec2-sg" {
  vpc_id      = var.vpc_id
  description = "${var.project.env}-${var.project.name}-${var.instance_name}-sg"
  name        = "${var.project.env}-${var.project.name}-${var.instance_name}-sg"
}

#Security Group Rule for ingress - uses ALB SG if provided, otherwise CIDR blocks
resource "aws_security_group_rule" "ingress-rule" {
  for_each = var.sg_ingress

  security_group_id        = aws_security_group.ec2-sg.id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  description              = each.value.description
  
  # Use ALB security group if provided, otherwise use CIDR blocks
  source_security_group_id = var.alb_sg_id != "" ? var.alb_sg_id : null
  cidr_blocks              = var.alb_sg_id == "" ? var.source_ingress_ec2_sg_cidr : null
}

resource "aws_security_group_rule" "egress-rule" {
  security_group_id = aws_security_group.ec2-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}