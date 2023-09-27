
resource "aws_security_group" "allow_sg" {
  for_each = var.ec2_sg
  name   = each.key
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = each.value["ingress_rules"]
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = each.value["egress_rules"]
    content {
      from_port   = egress.value["port"]
      to_port     = egress.value["port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }


  tags = {
    Name = var.Name
  }
}

# resource "aws_security_group_rule" "allow_sg_ingress" {
#   for_each          = var.sg_rules
#   type              = each.value["type"]
#   from_port         = each.value["port"]
#   to_port           = each.value["port"]
#   protocol          = each.value["protocol"]
#   cidr_blocks       = each.value["cidr_blocks"]
#   security_group_id = aws_security_group.allow_sg.id
# }
