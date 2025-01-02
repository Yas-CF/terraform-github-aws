resource "random_id" "id" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${random_id.id.hex}"

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