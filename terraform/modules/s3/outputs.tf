output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "The name of the S3 bucket created."
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket."
}

output "iam_role_arn" {
  value       = aws_iam_role.s3_backend_role.arn
  description = "The ARN of the IAM role for the S3 backend."
}

output "backend_config" {
  value = {
    bucket = aws_s3_bucket.bucket.bucket
    key    = "terraform/state/${var.environment}/terraform.tfstate"
    region = var.aws_region
  }
  description = "Configuration for Terraform S3 backend."
}
