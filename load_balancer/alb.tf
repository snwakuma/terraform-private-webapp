variable "name" {
  type        = string
  description = "name tag value"
}

variable "vpc_id" {
  type        = string
  description = "vpc id to launch the alb target group & sg"
}

variable "instance_id" {
  type        = string
  description = "instance id to attach to the target group"
}

variable "public_subnets" {
  type        = list(any)
  description = "public subnets to launch the alb into"

}

variable "tags" {
  type        = map(any)
  description = "tags for the vpc module"
}

resource "aws_security_group" "alb_sg" {
  name        = join("", [var.name, "-", "alb-sg"])
  description = "Allow  traffic for http and ssh"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_lb_target_group" "tg" {
  name        = join("", [var.name, "-", "target-group"])
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  tags        = var.tags

}

resource "aws_alb_target_group_attachment" "tgattachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id
  port             = 80
}

resource "aws_lb" "lb" {
  name               = join("", [var.name, "-", "alb"])
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets
  tags               = var.tags
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}


