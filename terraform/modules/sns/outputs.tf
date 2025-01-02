output "topic_arn" {
  value       = aws_sns_topic.example.arn
  description = "The ARN of the SNS topic"
}
output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}