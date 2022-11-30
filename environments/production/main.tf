module "api_instance" {
  source = "../../modules/instance"

  instance_name      = "api"
  namespace          = local.namespace
  security_group_ids = data.terraform_remote_state.shared.outputs.web_public_security_group_ids
  vpc_id             = data.terraform_remote_state.shared.outputs.vpc_id
}

module "bucket" {
  source = "../../modules/s3"

  bucket_name = "assets.${local.domain_name}"
  namespace   = local.namespace
}
