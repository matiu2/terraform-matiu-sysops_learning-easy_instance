locals {
  // Amazon Linux in pacific-south-east2
  ami_id  = "ami-0186908e2fdeea8f3"
  my_cidr = "${data.external.icanhazip_com.result.ip}/32"
}

data "external" "icanhazip_com" {
  // CIDR block of machine running the script to grant access to the security group
  program = ["curl", "https://api.ipify.org?format=json"]
}

// Security group

resource "aws_security_group" "cloud_watch" {
  name = "cloud_watch"
}

resource "aws_security_group_rule" "ingress" {
  count             = var.egress_ports
  security_group_id = aws_security_group.cloud_watch.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.ingress_ports[count.index]
  to_port           = var.ingress_ports[count.index]
  cidr_blocks       = [local.my_cidr]
}

resource "aws_security_group_rule" "egress" {
  count             = var.egress_ports
  security_group_id = aws_security_group.cloud_watch.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = var.egress_ports[count.index]
  to_port           = var.egress_ports[count.index]
  cidr_blocks       = ["0.0.0.0/0"]
}

// SSH Key (just load it from "~/.ssh/id_rsa.pub")

resource "aws_key_pair" "lab_key" {
  key_name   = "cloud_lab_key"
  public_key = file(var.ssh_public_key_file)
}

// Instance

resource "aws_instance" "sysops_study" {
  ami                         = local.ami_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.cloud_watch.id
  user_data                   = var.user_data
  security_groups             = [aws_security_group.cloud_watch.name]
  key_name                    = aws_key_pair.lab_key.key_name
  tags = {
    Name = "sysops_study"
  }
}
