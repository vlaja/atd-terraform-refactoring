output "ec2_pem_key" {
  description = "PEM version of the private key that can be used to connect to this instance."
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "ec2_elastic_ip" {
  description = "Elastic IP address for the EC2 instance."
  value       = aws_eip.this.public_ip
  sensitive   = true
}
