# creates ec2 instance
resource "aws_instance" "web" {
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
  associate_public_ip_address  = true
  availability_zone = "us-east-1a"
  key_name = aws_key_pair.class2.key_name
}


# creates a key pair
resource "aws_key_pair" "class2" {
  key_name   = "class2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
