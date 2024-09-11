# Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.is_internal
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_id
  subnets            = var.public_subnets_ids

  enable_deletion_protection = false

  tags = var.tags
}

# Target Group for ALB
resource "aws_lb_target_group" "target_group" {
  name                              = var.target_group_name
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = var.vpc_id
  target_type                       = "instance"
  load_balancing_cross_zone_enabled = var.load_balancing_cross_zone_enabled

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 15
    path                = var.health_check_path
    matcher             = "200"
    protocol            = "HTTP"
  }

  tags = var.tags
}

# Listener for ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = var.tags
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  condition {
    path_pattern {
      values = [var.health_check_path]
    }
  }
}
