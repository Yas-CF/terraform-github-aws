output "lambda_function_arn" {
  value       = aws_lambda_function.example.arn
  description = "The ARN of the Lambda function"
}

output "lambda_function_name" {
  value       = aws_lambda_function.example.function_name
  description = "The name of the Lambda function"
}
