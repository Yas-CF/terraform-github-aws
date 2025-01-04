output "backend_config" {
  value = {
    bucket = aws_s3_bucket.bucket.bucket
    key    = "terraform/state/${var.environment}/terraform.tfstate"
    region = var.aws_region
  }
  description = "Configuration for Terraform S3 backend."
}

# Outputs
output "bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of the S3 bucket created."
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket created."
}

output "s3_backend_role_arn" {
  value       = aws_iam_role.s3_backend_role.arn
  description = "The ARN of the IAM role for S3 backend."
}
