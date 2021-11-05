provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-alex-kolyago-training-state" {
  bucket = "terraform-alex-kolyago-training-state"

  # force_destroy = true

  #lifecycle {
  #  prevent_destroy = true
  #}

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-alex-kolyago-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
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

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform-alex-kolyago-training-state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}