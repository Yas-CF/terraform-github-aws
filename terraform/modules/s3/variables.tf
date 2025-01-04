variable "bucket_name" {
  description = "The base name for the S3 bucket"
  type        = string
}

variable "file_key" {
  description = "The S3 key under which to store the uploaded file"
  type        = string
}

variable "file_path" {
  description = "The local path to the Lambda function code ZIP file"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "The AWS region for the bucket"
  type        = string
}
