resource "aws_lb" "main_lb" {
    name = "${local.app_name}-alb"
    internal = false
    security_groups = [module.security_groups["alb_sg"].id]
    subnets = [for subnet in aws_subnet.public: subnet.id]
    tags  = merge(local.tags)
}

output "alb_name" {
  value = aws_lb.main_lb.name
}

resource "aws_lb_target_group" "main_lb_tg" {
    name_prefix     = "ttk-"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
    tags = merge(local.tags, { Name = "alb-tgt-grp-test" })
    target_type = "ip"

    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        matcher             = "200"
    }
  
  lifecycle {
    create_before_destroy = true 
  }
}

output "aws_lb_target_group" {
    description = "AWS LB target group ID"
    value = aws_lb_target_group.main_lb_tg.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_lb_tg.arn
  }
}