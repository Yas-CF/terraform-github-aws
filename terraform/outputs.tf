# outputs.tf
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC created"
}

output "public_subnet_id" {
  value       = module.subnets.public_subnet_id
  description = "The ID of the public subnet created"
}

output "private_subnet_id" {
  value       = module.subnets.private_subnet_id
  description = "The ID of the private subnet created"
}

output "internet_gateway_id" {
  value       = module.gateway.gateway_id
  description = "The ID of the internet gateway"
}


output "ec2_security_group_id" {
  value       = module.ec2_api_server.security_group_id
  description = "ID of the security group attached to the EC2 instance"
}

output "s3_bucket_name" {
  value       = module.s3.bucket_name
  description = "The name of the S3 bucket created."
}

output "s3_object_key" {
  value       = module.s3.object_key
  description = "The key of the object stored in the S3 bucket."
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "SQS_Queue_URL" {
  value       = module.sqs.queue_url
  description = "URL of the deployed SQS queue"
}

output "SNS_Topic_ARN" {
  value       = module.sns.topic_arn
  description = "ARN of the deployed SNS topic"
}

output "cloudwatch_log_group_name" {
  value = module.cloudwatch.cloudwatch_log_group_name
}