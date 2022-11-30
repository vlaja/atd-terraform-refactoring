data "terraform_remote_state" "shared" {
  backend = "remote"

  config = {
    organization = "atd-vlaja"
    workspaces = {
      name = "shared"
    }
  }
}
