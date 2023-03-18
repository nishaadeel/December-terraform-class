# creates ec2 instance
resource "aws_instance" "web" {
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
  associate_public_ip_address  = true
  availability_zone = "us-east-1a"
}



