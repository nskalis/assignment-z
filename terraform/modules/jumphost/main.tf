resource "aws_security_group" "to_jumphost" {
  name        = "to-jumphost"
  description = "from inet to jumphost (ssh)"
  vpc_id      = var.vpc_id

  ingress {
    description = "from inet to jumphost (shh)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # todo: use home/office/vpn ip range instead
  }
  egress {
    description = "from jumphost to inet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.labels
}

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "jumphost" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=f3c6436"

  name                   = "jumphost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t3.micro"
  key_name               = var.ec2_key_pair_name
  subnet_id              = var.jumphost_subnet_id
  vpc_security_group_ids = [aws_security_group.to_jumphost.id]

  tags = var.labels
}

resource "aws_eip" "jumphost_eip" {
  depends_on = [var.vpc_id, module.jumphost]
  instance   = module.jumphost.id
  domain     = "vpc"

  tags = var.labels
}

resource "null_resource" "copy_ec2_private_key" {
  depends_on = [module.jumphost]

  connection {
    type        = "ssh"
    host        = aws_eip.jumphost_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("${path.module}/../../environments/${var.environment}/files/${var.ec2_private_key_filename}")
  }
  provisioner "file" {
    source      = "${path.module}/../../environments/${var.environment}/files/${var.ec2_private_key_filename}"
    destination = "/tmp/${var.ec2_private_key_filename}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 0400 /tmp/${var.ec2_private_key_filename}"
    ]
  }
}
