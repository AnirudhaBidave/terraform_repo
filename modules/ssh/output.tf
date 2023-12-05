output "public_key" {
  description = "The public key data in OpenSSH authorized_keys format"
  value       = tls_private_key.ssh_key.public_key_openssh
}

output "key_pair" {
  description = "The key pair name"
  value       = aws_key_pair.ec2_key_pair.public_key
}

output "private_key_pem" {
  description = "The private key in PEM format"
  value       = tls_private_key.ssh_key.private_key_pem
  # sensitive   = true
}

output "key_name" {
  value = aws_key_pair.ec2_key_pair.key_name
}