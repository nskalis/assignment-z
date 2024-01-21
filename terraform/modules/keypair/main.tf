resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "pem_file" {
  filename = pathexpand("${path.module}/../../environments/${var.environment}/files/${var.ec2_private_key_filename}")
  content  = tls_private_key.ec2_private_key.private_key_pem
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.ec2_key_pair_name
  public_key = tls_private_key.ec2_private_key.public_key_openssh

  tags = var.labels
}
