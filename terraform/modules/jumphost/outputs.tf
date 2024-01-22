output "ssh_from_jumphost_sg" {
  description = "security group allowing ssh from the jumphost only"
  value       = aws_security_group.ssh_from_jumphost.id
}