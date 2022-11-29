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

output "acceptance_ec2_pem_key" {
  description = "Acceptance PEM version of the private key that can be used to connect to this instance."
  value       = module.acceptance.ec2_pem_key
  sensitive   = true
}

output "acceptance_ec2_elastic_ip" {
  description = "Acceptance Elastic IP address for the EC2 instance."
  value       = module.acceptance.ec2_elastic_ip
  sensitive   = true
}

output "prod_ec2_pem_key" {
  description = "Production PEM version of the private key that can be used to connect to this instance."
  value       = module.production.ec2_pem_key
  sensitive   = true
}

output "prod_ec2_elastic_ip" {
  description = "Production Elastic IP address for the EC2 instance."
  value       = module.production.ec2_elastic_ip
  sensitive   = true
}
