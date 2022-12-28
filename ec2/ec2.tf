variable "name" {
  type        = string
  description = "name tag value"
}

variable "vpc_id" {
  type        = string
  description = "vpc id to launch SG"
}

variable "subnet_id" {
  type        = string
  description = "subnet to launch the instance"
}

variable "alb_sg_id" {
  type        = string
  description = "alb sg id to allow the least privilaged traffic"
}

variable "tags" {
  type        = map(any)
  description = "tags for the vpc module"
}

variable "iam_role_name" {
  type        = string
  description = "iam role name to attach to the instance profile"
}

resource "aws_security_group" "ec2_sg" {
  name        = join("", [var.name, "-", "ec2-sg"])
  description = "Allow  traffic for http and ssh"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }


  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = join("", [var.name, "-", "iam-instance-profile"])
  role = var.iam_role_name
}



resource "aws_instance" "web_server" {
  ami                    = "ami-01cae1550c0adea9c"
  instance_type          = "t3.small"
  key_name               = "ta"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("scripts/userdata.sh")
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  tags                   = merge(var.tags, { Name = join("", [var.name, "-", "webserver"]) })

}
