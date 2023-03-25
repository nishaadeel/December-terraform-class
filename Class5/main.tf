resource "aws_key_pair" "state-demo" {
  key_name   = "state-demo-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "state-demo2" {
  key_name   = "state-demo2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}