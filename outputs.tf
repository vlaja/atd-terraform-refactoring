output "dev_ec2_pem_key" {
  description = "Development PEM version of the private key that can be used to connect to this instance."
  value       = module.dev.ec2_pem_key
  sensitive   = true
}

output "dev_ec2_elastic_ip" {
  description = "Development Elastic IP address for the EC2 instance."
  value       = module.dev.ec2_elastic_ip
  sensitive   = true
}
