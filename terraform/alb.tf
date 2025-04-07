resource "aws_lb" "medusa_alb" {
  name               = "medusa-alb"
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  security_groups    = [aws_security_group.medusa_sg.id]

  enable_deletion_protection = false

  tags = {
    Name = "medusa-alb"
  }
}

# Target Group for ECS Fargate
resource "aws_lb_target_group" "medusa_tg" {
  name        = "medusa-tg"
  port        = 9000
  protocol    = "HTTP"
  target_type = "ip"                       # Important for ECS Fargate
  vpc_id      = aws_vpc.medusa_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "medusa-target-group"
  }
}

# Nginx Target Group for Reverse Proxy
resource "aws_lb_target_group" "nginx_tg" {
  name        = "nginx-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"                       # Important for ECS Fargate
  vpc_id      = aws_vpc.medusa_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# Listener for HTTP traffic
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.medusa_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.medusa_tg.arn
  }
}

resource "aws_lb_listener_rule" "nginx_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }

  condition {
    path_pattern {
      values = ["/nginx*"]
    }
  }
}
