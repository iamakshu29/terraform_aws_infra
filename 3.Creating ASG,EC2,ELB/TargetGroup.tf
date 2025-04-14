data "aws_vpc" "default_id" {
  default = true
}

resource "aws_lb_target_group" "alb-target_group" {
  name        = "tf-lb-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id = data.aws_vpc.default_id.id

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = "2"
      minimum_healthy_targets_percentage = "off"
    }

    unhealthy_state_routing {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
  }
}