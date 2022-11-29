resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "${local.resource_name}-ssh"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id                   = data.aws_subnets.selected.ids[0]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.ssh.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${local.resource_name}-ec2"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id

  tags = {
    Name = "${local.resource_name}-eip"
  }

  tags_all = {
    Name = "${local.resource_name}-eip"
  }
}
