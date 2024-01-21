output "ec2_private_key" {
  description = "ec2 private key (ssh)"
  value       = tls_private_key.ec2_private_key.private_key_pem
  sensitive   = true
}

output "ec2_key_pair_name" {
  description = "the key name for the key pair"
  value       = aws_key_pair.ec2_key_pair.key_name
}