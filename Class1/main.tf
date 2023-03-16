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