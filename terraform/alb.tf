# ALB
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

# ALB TG PORT 9000 FOR MEDUSA
resource "aws_lb_target_group" "medusa_tg" {
  name        = "medusa-tg-v1"
  port        = 9000
  protocol    = "HTTP"
  target_type = "ip"
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

# ALB LISTERNER PORT 80
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.medusa_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.medusa_tg.arn
  }
}
