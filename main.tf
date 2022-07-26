terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_security_group" "devops-sec-group" {
  name        = var.security_group
  description = var.security_group
  vpc_id      = var.vpc

  // to grant ssh and http permissions
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "demo_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet
  associate_public_ip_address = var.publicip
  key_name                    = var.keyname

  vpc_security_group_ids = [
    aws_security_group.devops-sec-group.id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = 50
    volume_type           = "gp2"
  }

  tags = {
    Name        = "Demo-Server"
    Environment = "DEV"
    OS          = "UBUNTU"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  depends_on = [
    aws_security_group.devops-sec-group
  ]
}

output "ec2instance" {
  value = aws_instance.demo_ec2.public_ip
}
