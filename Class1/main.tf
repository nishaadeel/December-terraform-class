resource "aws_iam_user" "firstuser" {
  for_each = toset([
    "firstuser",
    "seconduser",
    "thirduser",
  ])
  name = each.key
}


resource "aws_iam_group" "multigroup" {
  for_each = toset([
    "sales",
    "marketing",
    "develop",
  ])
  name = each.key
}

resource "aws_key_pair" "first" {
  key_name   = "first-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "b" {
  bucket_prefix = "my-"
}
