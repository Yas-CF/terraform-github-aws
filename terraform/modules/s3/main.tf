resource "random_id" "id" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${random_id.id.hex}"
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = var.file_key
  source = var.file_path
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
