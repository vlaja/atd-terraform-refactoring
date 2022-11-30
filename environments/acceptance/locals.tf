locals {
  namespace              = "acceptance"
  domain_name            = "larva.cloud"
  namespaced_domain_name = "${local.namespace}.${local.domain_name}"
}
