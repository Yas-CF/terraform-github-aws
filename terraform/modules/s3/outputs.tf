output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "The name of the S3 bucket created."
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket."
}

output "backend_config" {
  value = {
    bucket = aws_s3_bucket.bucket.bucket
    key    = "terraform/state/${var.environment}/terraform.tfstate"
    region = "us-east-1"
  }
  description = "Backend configuration for Terraform remote state."
}
