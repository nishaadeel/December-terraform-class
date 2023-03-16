resource "aws_iam_user" "firstuser" {
  for_each = toset([
    "firstuser",
    "seconduser",
    "thirduser",
  ])
  name = each.key
}
