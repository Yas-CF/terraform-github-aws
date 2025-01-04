
output "bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of the S3 bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket."
}

output "s3_backend_role_arn" {
  value       = aws_iam_role.s3_backend_role.arn
  description = "The ARN of the IAM role for S3 backend."
}
