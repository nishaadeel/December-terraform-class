resource "aws_key_pair" "state-demo" {
  key_name   = var.key_name1
  public_key = file(var.public_key)
  tags       = var.tags
}

resource "aws_key_pair" "state-demo2" {
  key_name   = var.key_name2
  public_key = file(var.public_key)
  tags       = var.tags
}

resource "aws_security_group" "important" {
  name        = "important"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags       = var.tags
}