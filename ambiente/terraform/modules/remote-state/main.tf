provider "aws" {
  #region = "us-east-1"
}
resource "aws_s3_bucket" "conchayoro_remote_store" {
  bucket = "conchayoro-remote-store"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  force_destroy = false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}