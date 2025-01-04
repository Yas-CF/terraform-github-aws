variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "file_key" {
  description = "The key of the file in the S3 bucket"
  type        = string
}

variable "queue_url" {
  description = "The URL of the SQS queue"
  type        = string
}

variable "topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

