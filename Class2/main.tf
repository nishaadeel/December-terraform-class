# creates a key pair
resource "aws_key_pair" "class2" {
  key_name   = "class2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# creates sec group
resource "aws_security_group" "class2" {
  name        = "class2"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# creates an EBS Volume 
resource "aws_ebs_volume" "class2" {
  availability_zone = "us-east-1a"
  size              = 40
}


# creates ec2 instance
resource "aws_instance" "web" {
  ami                         = "ami-02f3f602d23f1659d"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.class2.key_name
  user_data = file("wordpress_install.sh")
  vpc_security_group_ids = [
    aws_security_group.class2.id,
  ]
}

# creates ec2 instance
resource "aws_instance" "web2" {
  ami                         = "ami-02f3f602d23f1659d"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.class2.key_name
  vpc_security_group_ids = [
    aws_security_group.class2.id,
  ]
}

# terraform import aws_instance.mine    i-0efeb1db621f7809d
resource "aws_instance" "mine" {
  ami = "ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
}




# # attaches volume to an instance
# resource "aws_volume_attachment" "class2" {
#   device_name = "/dev/sdb"
#   volume_id   = aws_ebs_volume.class2.id
#   instance_id = aws_instance.web.id
# }


# # creates DNS Record
# resource "aws_route53_record" "class2" {
#   allow_overwrite = true
#   zone_id         = var.zone_id
#   name            = "blog.${var.domain}"
#   type            = "A"
#   ttl             = 300
#   records         = [aws_instance.web.public_ip]
# }

# variable "zone_id" {}
# variable "domain" {}