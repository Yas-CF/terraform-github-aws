variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket containing the Lambda function code"
  type        = string
}

variable "file_key" {
  description = "The key of the Lambda function code in S3"
  type        = string
}

variable "queue_arn" {
  description = "The ARN of the SQS queue"
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
