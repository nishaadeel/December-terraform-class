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
