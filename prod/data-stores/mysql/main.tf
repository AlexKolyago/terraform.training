provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-alex-kolyago-training-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-alex-kolyago-state"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = true
}