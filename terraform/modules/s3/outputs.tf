output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "The name of the S3 bucket created."
}

output "object_key" {
  value       = aws_s3_object.lambda_code.key
  description = "The key of the object stored in the S3 bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket."
}
