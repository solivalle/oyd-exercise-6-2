# ── ALB security group ────────────────────────────────────────────────────────
resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP from internet to ALB"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ALB SG: the one legitimate open rule
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ── Target group ──────────────────────────────────────────────────────────────
resource "aws_lb_target_group" "this" {
  name        = "${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
  }

  tags = {
    Name = "${var.environment}-tg"
  }
}

