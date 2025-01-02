output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.ec2_logs.name
  description = "The name of the CloudWatch Log Group for EC2 logs"
}

