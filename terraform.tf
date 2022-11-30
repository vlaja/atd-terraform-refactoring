terraform {
  backend "remote" {
    organization = "atd-vlaja"

    workspaces {
      name = "monolith"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = "> 0.14"
}
