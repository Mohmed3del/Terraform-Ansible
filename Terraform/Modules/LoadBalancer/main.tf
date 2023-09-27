resource "aws_lb" "load_balancer" {
  for_each = var.load_balancers

  name               = each.key
  internal           = each.value.internal
  load_balancer_type = each.value.type == "application" ? "application" : "network"
  subnets            = var.subnets_id
  security_groups    = var.security_groups
}

resource "aws_lb_listener" "load_balancer_listener" {
  for_each = var.load_balancers

  load_balancer_arn = aws_lb.load_balancer[each.key].arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_tg[each.key][0].arn
  }
}

resource "aws_lb_target_group" "load_balancer_tg" {
  for_each = { for k, v in var.load_balancers : k => v.target_groups }

  name       = each.key
  target_type = "ip"
  port       = each.value[0].port
  protocol   = each.value[0].protocol
  vpc_id     = var.vpc_id
}
resource "aws_lb_target_group_attachment" "load_balancer_tg_attachment" {
  for_each = {
    for k, v in var.load_balancers :
    k => v.target_groups
  }

  target_group_arn = aws_lb_target_group.load_balancer_tg[each.key].arn
  target_id        = var.type_id[each.key] # Adjust this according to your configuration
  port             = each.value[0].port
}
