provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-alex-kolyago-state" {
  bucket = "terraform-state"

  # force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

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
  name = "terraform-alex-kolyago-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}