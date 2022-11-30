output "vpc_id" {
  description = "ID of the Virtual Private Cloud."
  value       = module.vpc.vpc_id
  sensitive   = true
}

output "web_public_security_group_ids" {
  description = "ID-s of security groups for the api instances."
  value       = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
}

