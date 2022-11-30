output "ec2_pem_key" {
  description = "PEM version of the private key that can be used to connect to this instance."
  value       = module.api_instance.ec2_pem_key
  sensitive   = true
}

output "ec2_elastic_ip" {
  description = "Elastic IP address for the EC2 instance."
  value       = module.api_instance.ec2_elastic_ip
  sensitive   = true
}
