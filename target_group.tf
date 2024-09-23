resource "aws_alb_target_group" "main" {
  name = format("%s-%s", var.cluster_name, var.cluster_name)

  port   = var.service-port
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    healthy_threshold   = lookup(var.service_healthcheck, "health_threshold", "3")
    unhealthy_threshold = lookup(var.service_healthcheck, "unhealth_threshold", "10")
    timeout             = lookup(var.service_healthcheck, "timeout", "10")
    interval            = lookup(var.service_healthcheck, "interval", "10")
    matcher             = lookup(var.service_healthcheck, "matcher", "200")
    path                = lookup(var.service_healthcheck, "path", "/")
    port                = lookup(var.service_healthcheck, "port", var.service-port)
  }
  lifecycle {
    create_before_destroy = false
  }
}