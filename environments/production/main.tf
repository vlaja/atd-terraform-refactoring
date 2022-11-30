module "api_instance" {
  source = "../../modules/instance"

  instance_name      = "api"
  namespace          = "production"
  security_group_ids = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
  vpc_id             = module.vpc.vpc_id
}

module "bucket" {
  source = "../../modules/s3"

  bucket_name = "assets.${local.domain_name}"
  namespace   = local.namespace
}
