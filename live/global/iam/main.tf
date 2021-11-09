provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "example" {
  for_each  = toset(var.user_names)
  name      = each.value
}