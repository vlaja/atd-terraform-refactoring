module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "${local.project_name}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "ssh" {
  name   = "ssh"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http_https_public" {
  name   = "http-https-public"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "dev" {
  source = "./modules/instance"

  instance_name      = "api"
  namespace          = "development"
  security_group_ids = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
  vpc_id             = module.vpc.vpc_id
}

module "acceptance" {
  source = "./modules/instance"

  instance_name      = "api"
  namespace          = "acceptance"
  security_group_ids = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
  vpc_id             = module.vpc.vpc_id
}

module "production" {
  source = "./modules/instance"

  instance_name      = "api"
  namespace          = "production"
  security_group_ids = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
  vpc_id             = module.vpc.vpc_id
}
