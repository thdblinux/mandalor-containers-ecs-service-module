resource "aws_alb_target_group" "main" {
  name = format("%s-%s", var.cluster_name, var.service_name)

  port   = var.service_port
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    healthy_threshold   = lookup(var.service_healthcheck, "health_threshold", "3")
    unhealthy_threshold = lookup(var.service_healthcheck, "unhealthy_threshold", "10") # Fixed typo
    timeout             = lookup(var.service_healthcheck, "timeout", "10")             # Removed extra `=`
    interval            = lookup(var.service_healthcheck, "interval", "10")            # Removed extra `=`
    matcher             = lookup(var.service_healthcheck, "matcher", "200")            # Removed extra `=`
    path                = lookup(var.service_healthcheck, "path", "/")
    port                = lookup(var.service_healthcheck, "port", var.service_port)
  }

  lifecycle {
    create_before_destroy = false
  }

}
