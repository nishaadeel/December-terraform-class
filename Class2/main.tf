# creates a key pair
resource "aws_key_pair" "class2" {
  key_name   = "class2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


# creates ec2 instance
resource "aws_instance" "web" {
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
  associate_public_ip_address  = true
  availability_zone = "us-east-1a"
  key_name = aws_key_pair.class2.key_name
}



# creates sec group
resource "aws_security_group" "class2" {
  name        = "class2"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}