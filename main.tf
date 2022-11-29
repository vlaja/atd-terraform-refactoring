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

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "${local.project_name}-ssh"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
  key_name                    = aws_key_pair.ssh.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${local.project_name}-ec2"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id

  tags = {
    Name = "${local.project_name}-eip"
  }

  tags_all = {
    Name = "${local.project_name}-eip"
  }
}

# module "dev" {
#   source = "./modules/instance"

#   instance_name      = "api"
#   namespace          = "development"
#   security_group_ids = [aws_security_group.ssh.id, aws_security_group.http_https_public.id]
#   vpc_id             = module.vpc.vpc_id
# }
